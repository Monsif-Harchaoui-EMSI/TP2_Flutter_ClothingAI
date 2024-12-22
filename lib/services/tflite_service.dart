import 'package:tflite/tflite.dart';

class TFLiteService {
  Future<void> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/models/1.tflite",
        labels: "assets/models/labels.txt",
      );
      print("Model loaded: $res");
    } catch (e) {
      print("Failed to load the model: $e");
    }
  }

  Future<String?> classifyImageFromUrl(String imageUrl) async {
    try {
      // Simulate downloading the image to a local path
      // You can use a library like `http` to download the image.
      String localPath = imageUrl; // Replace with actual path if downloading.
      var recognitions = await Tflite.runModelOnImage(
        path: localPath,
        numResults: 1,
        threshold: 0.5, // Confidence threshold
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        return recognitions.first['label'] as String?;
      } else {
        return "Unknown";
      }
    } catch (e) {
      print("Error during image classification: $e");
      return null;
    }
  }

  Future<void> disposeModel() async {
    await Tflite.close();
  }
}
