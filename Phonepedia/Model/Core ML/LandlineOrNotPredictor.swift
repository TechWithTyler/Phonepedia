//
//  LandlineOrNotPredictor.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import Vision

class LandlineOrNotPredictor {

    // MARK: - Prediction Struct

    // Stores a classification name for an image classifier's prediction.
    struct Prediction {
        
        // The name of the object or scene the image classifier recognizes in an image.
        let classification: String
        
        // Whether the image contains landline phones.
        var isLandline: Bool {
            return classification == "Landline"
        }
        
    }

    // MARK: - Type Aliases

    // Change the number after V when a new version is created. Make sure to name new versions "LandlineOrNotVX", where X represents the version number.
    typealias CurrentLandlineOrNot = LandlineOrNotV1

    // The function signature the caller must provide as a completion handler.
    typealias ImagePredictionHandler = (_ prediction: Prediction?, _ photoData: Data, _ phone: Phone) -> Void

    // MARK: - Properties - Photo Manager

    // The photo manager to pass predictions back to.
    var photoManager: PhonePhotoManager

    // MARK: - Properties - Dictionaries

    // A dictionary of prediction handler functions, each keyed by its Vision request.
    private var predictionHandler: ImagePredictionHandler? = nil

    // MARK: - Properties - Image Classifier

    // The image classifier for classification requests.
    var imageClassifier: VNCoreMLModel? {
        // 1. Create a default model configuration.
        let defaultConfig = MLModelConfiguration()
        // 2. Try to create an instance of the image classifier's wrapper class. If that fails, return nil.
        // Throwing functions don't have to be called within the do block of a do-catch statement--the result of calling the function can be an Optional value which returns nil if it throws an error.
        let imageClassifierWrapper = try? CurrentLandlineOrNot(configuration: defaultConfig)
        guard let imageClassifier = imageClassifierWrapper else {
            return nil
        }
        // 3. Get the underlying model instance.
        let imageClassifierModel = imageClassifier.model
        // 4. Create a Vision instance using the image classifier's model instance.
        let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel)
        guard let visionModel = imageClassifierVisionModel else {
            return nil
        }
        // 5. Return the vision model.
        return visionModel
    }

    // MARK: - Initialization

    init(photoManager: PhonePhotoManager) {
        self.photoManager = photoManager
    }

    // MARK: - Image Classification - Request

    // This method generates a new request instance that uses the Image Predictor's image classifier model.
    private func createImageClassificationRequest(photoData: Data, phone: Phone) -> VNImageBasedRequest? {
        // 1. Create an image classification request with an image classifier model.
        guard let imageClassifier = imageClassifier else {
            return nil
        }
        let imageClassificationRequest = VNCoreMLRequest(model: imageClassifier) {
            [self] request, error in
            visionRequestHandler(request, error: error, photoData: photoData, phone: phone)
        }
        // 2. Set the crop and scale option.
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        // 3. Return the request.
        return imageClassificationRequest
    }

    // MARK: - Image Classification - Predictions

    // This method generates an image classification prediction for a photo.
    func makePredictions(for photoData: Data, phone: Phone, completionHandler: @escaping ImagePredictionHandler) {
        // 1. Make sure we can decode the photo data to an NSImage or UIImage.
        #if os(macOS)
        let image = NSImage(data: photoData)
        #else
        let image = UIImage(data: photoData)
        #endif
        guard let photo = image else {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .noImageForPrediction
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        // 2. Convert the NSImage/UIImage to CGImage.
        #if os(macOS)
        let orientation = CGImagePropertyOrientation.up
        var imageRect = CGRect(origin: .zero, size: photo.size)
        guard let photoImage = photo.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .noUnderlyingImageForPrediction
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        #else
        let orientation = CGImagePropertyOrientation(photo.imageOrientation)
        guard let photoImage = photo.cgImage else {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .noUnderlyingImageForPrediction
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        #endif
        // 3. Create an image classification request.
        guard let imageClassificationRequest = createImageClassificationRequest(photoData: photoData, phone: phone) else {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .predictionRequestFailed
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        // 4. Set the completion handler of the image classification request.
        predictionHandler = completionHandler
        // 5. Create a VNImageRequestHandler.
        let imageClassificationRequestHandler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        // 6. Create an array to hold a single VNRequest object. This is done because the following method call, which performs the image classification request, requires an array of VNRequests as its argument.
        let requests: [VNRequest] = [imageClassificationRequest]
        // 7. Try to start the image classification request.
        do {
            try imageClassificationRequestHandler.perform(requests)
        } catch {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .unknownPredictionFailure(reason: error.localizedDescription)
                photoManager.showingPhonePhotoErrorAlert = true
            }
        }
    }

    // MARK: - Vision Request Completion Handler

    // This method is called by Vision when it completes a request. The method checks for errors and validates the request's results.
    private func visionRequestHandler(_ request: VNRequest, error: Error?, photoData: Data, phone: Phone) {
        // 1. Create a Prediction. Start with a nil value in case there's a problem.
        var prediction: Prediction? = nil
        // 2. Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler?(prediction, photoData, phone)
        }
        // 3. Check for an error.
        if let error = error {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .unknownPredictionFailure(reason: error.localizedDescription)
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        // 4. Check that the results aren't nil. If they're nil, show an error.
        if request.results == nil {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .predictionNoResults
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        // 5. Try to cast the request's results as a VNClassificationObservation array. If that fails, show an error.
        guard let observations = request.results as? [VNClassificationObservation] else {
            DispatchQueue.main.async { [self] in
                photoManager.phonePhotoError = .predictionWrongResultType(resultType: type(of: request.results))
                photoManager.showingPhonePhotoErrorAlert = true
            }
            return
        }
        // 6. Create a prediction array from the observations.
        let predictions = observations.map { observation in
            // Convert each observation into a LandlineOrNotPredictor.Prediction instance.
            Prediction(classification: observation.identifier)
        }
        // 7. Get the first prediction from the array.
        prediction = predictions.first
    }
    
}
