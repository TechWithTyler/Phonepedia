//
//  LandlineOrNotPredictor.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import Vision

class LandlineOrNotPredictor {
    
    @ObservedObject var photoViewModel: PhonePhotoViewModel
    
#if os(macOS)
    typealias CrossPlatformImage = NSImage
#else
    typealias CrossPlatformImage = UIImage
#endif
    
    // Change the number after V when a new version is created. Make sure to name new versions "LandlineOrNotVX" where X represents the version number.
    typealias CurrentLandlineOrNot = LandlineOrNotV1

    // A common image classifier instance that all Image Predictor instances use to generate predictions.
    private static let imageClassifier = createImageClassifier()

    // Stores a classification name for an image classifier's prediction.
    struct Prediction {
        
        // The name of the object or scene the image classifier recognizes in an image.
        let classification: String
        
        // Whether the image contains landline phones.
        var isLandline: Bool {
            return classification == "Landline"
        }
        
    }

    // The function signature the caller must provide as a completion handler.
    typealias ImagePredictionHandler = (_ predictions: [Prediction]?, _ photoData: Data, _ phone: Phone) -> Void

    // A dictionary of prediction handler functions, each keyed by its Vision request.
    private var predictionHandlers = [VNRequest : ImagePredictionHandler]()
    
    init(photoViewModel: PhonePhotoViewModel) {
        self.photoViewModel = photoViewModel
    }
    
    static func createImageClassifier() -> VNCoreMLModel {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()
        // Create an instance of the image classifier's wrapper class.
        // Throwing functions don't have to be called within the do block of a do-catch statement--the result of calling the function can be an Optional value which returns nil if it throws an error.
        let imageClassifierWrapper = try? CurrentLandlineOrNot(configuration: defaultConfig)
        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }
        // Get the underlying model instance.
        let imageClassifierModel = imageClassifier.model
        // Create a Vision instance using the image classifier's model instance.
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a VNCoreMLModel instance.")
        }
        return imageClassifierVisionModel
    }

    // Generates a new request instance that uses the Image Predictor's image classifier model.
    private func createImageClassificationRequest(photoData: Data, phone: Phone) -> VNImageBasedRequest {
        // Create an image classification request with an image classifier model.
        let imageClassificationRequest = VNCoreMLRequest(model: LandlineOrNotPredictor.imageClassifier) {
            request, error in
            self.visionRequestHandler(request, error: error, photoData: photoData, phone: phone)
        }
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        return imageClassificationRequest
    }

    // Generates an image classification prediction for a photo.
    func makePredictions(for photoData: Data, phone: Phone, completionHandler: @escaping ImagePredictionHandler) throws {
        // 1. Make sure we can decode the photo data to an NSImage or UIImage.
        guard let photo = CrossPlatformImage(data: photoData) else {
            fatalError("Failed to create image from data.")
        }
        // 2. Convert the NSImage/UIImage to CGImage.
        #if os(macOS)
        let orientation = CGImagePropertyOrientation.up
        var imageRect = CGRect(origin: .zero, size: photo.size)
        guard let photoImage = photo.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
            fatalError("NSImage doesn't have underlying CGImage.")
        }
        #else
        let orientation = CGImagePropertyOrientation(photo.imageOrientation)
        guard let photoImage = photo.cgImage else {
            fatalError("UIImage doesn't have underlying CGImage.")
        }
        #endif
        // 3. Create an image classification request.
        let imageClassificationRequest = createImageClassificationRequest(photoData: photoData, phone: phone)
        // 4. Set the completion handler of the image classification request.
        predictionHandlers[imageClassificationRequest] = completionHandler
        // 5. Create a VNImageRequestHandler.
        let imageClassificationRequestHandler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        // 6. Create an array to hold a single VNRequest object. This is done because the following method call, which performs the image classification request, requires an array of VNRequests as its argument.
        let requests: [VNRequest] = [imageClassificationRequest]
        // 7. Try to start the image classification request. Any errors thrown by this method call are rethrown by this method.
        try imageClassificationRequestHandler.perform(requests)
    }

    // The completion handler method that Vision calls when it completes a request. The method checks for errors and validates the request's results.
    private func visionRequestHandler(_ request: VNRequest, error: Error?, photoData: Data, phone: Phone) {
        // 1. Remove the caller's handler from the dictionary and keep a reference to it.
        guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
            fatalError("Every request must have a prediction handler.")
        }
        // 2. Create an array of Predictions. Start with a nil value in case there's a problem.
        var predictions: [Prediction]? = nil
        // 3. Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions, photoData, phone)
        }
        // 4. Check for an error.
        if let error = error {
            photoViewModel.phonePhotoError = .predictionFailed(reason: error.localizedDescription)
            return
        }
        // 5. Check that the results aren't nil. If they're nil, log an error.
        if request.results == nil {
            photoViewModel.phonePhotoError = .predictionFailed(reason: "Vision request had no results.")
            return
        }
        // 6. Try to cast the request's results as a VNClassificationObservation array. If that fails, log an error.
        guard let observations = request.results as? [VNClassificationObservation] else {
            photoViewModel.phonePhotoError = .predictionFailed(reason: "VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        // 7. Create a prediction array from the observations.
        predictions = observations.map { observation in
            // Convert each observation into a LandlineOrNotPredictor.Prediction instance.
            Prediction(classification: observation.identifier)
        }
    }
    
}
