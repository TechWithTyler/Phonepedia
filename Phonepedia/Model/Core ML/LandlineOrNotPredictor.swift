//
//  LandlineOrNotPredictor.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/23.
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

    // Stores a classification name and confidence for an image classifier's prediction.
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
        guard let photo = CrossPlatformImage(data: photoData) else {
            fatalError("Failed to create image from data.")
        }
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
        let imageClassificationRequest = createImageClassificationRequest(photoData: photoData, phone: phone)
        predictionHandlers[imageClassificationRequest] = completionHandler
        let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        let requests: [VNRequest] = [imageClassificationRequest]
        // Start the image classification request.
        try handler.perform(requests)
    }

    // The completion handler method that Vision calls when it completes a request. The method checks for errors and validates the request's results.
    private func visionRequestHandler(_ request: VNRequest, error: Error?, photoData: Data, phone: Phone) {
        // Remove the caller's handler from the dictionary and keep a reference to it.
        guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
            fatalError("Every request must have a prediction handler.")
        }
        // Start with a nil value in case there's a problem.
        var predictions: [Prediction]? = nil
        // Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions, photoData, phone)
        }
        // Check for an error first.
        if let error = error {
            photoViewModel.phonePhotoError = .predictionFailed(reason: error.localizedDescription)
            return
        }
        // Check that the results aren't nil.
        if request.results == nil {
            print("Vision request had no results.")
            return
        }
        // Cast the request's results as an VNClassificationObservation array.
        guard let observations = request.results as? [VNClassificationObservation] else {
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        // Create a prediction array from the observations.
        predictions = observations.map { observation in
            // Convert each observation into a LandlineOrNotPredictor.Prediction instance.
            Prediction(classification: observation.identifier)
        }
    }
    
}
