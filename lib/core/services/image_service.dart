import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snake_bite_app/core/api/api_config.dart';
import 'package:snake_bite_app/features/result/result.dart';

class ImageService {
  static Future<void> getPredictions(
      File? imageFile, BuildContext context) async {
    final mlUrl = ApiConfig.getBaseUrl('predict');

    if (imageFile == null) {
      print("No image file provided.");
      return;
    }

    try {
      var request = http.MultipartRequest('POST', mlUrl)
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        _handleResponseData(responseData, context);
      } else if (response.statusCode == 307) {
        final newUrl = response.headers['location'];
        if (newUrl != null) {
          await _redirectAndGetPredictions(imageFile, newUrl, context);
        } else {
          print("No redirect URL found.");
        }
      } else {
        print("Failed to get predictions: ${response.statusCode}");
      }
    } catch (e) {
      print("Error getting predictions: $e");
    }
  }

  static Future<void> _redirectAndGetPredictions(
      File imageFile, String newUrl, BuildContext context) async {
    try {
      var newRequest = http.MultipartRequest('POST', Uri.parse(newUrl))
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var newResponse = await newRequest.send();

      if (newResponse.statusCode == 200) {
        final newResponseData = await newResponse.stream.bytesToString();
        _handleResponseData(newResponseData, context);
      } else {
        print(
            "Failed to get predictions from redirect: ${newResponse.statusCode}");
      }
    } catch (e) {
      print("Error during redirect request: $e");
    }
  }

  static void _handleResponseData(String responseData, BuildContext context) {
    try {
      final decodedData = jsonDecode(responseData);
      if (decodedData.containsKey('Predicted Class')) {
        final predictedClass = decodedData['Predicted Class'];
        print(predictedClass);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(predictedClass: predictedClass),
          ),
        );
      } else {
        print("Predicted Class not found in response.");
      }
    } catch (e) {
      print("Error parsing response data: $e");
    }
  }
}
