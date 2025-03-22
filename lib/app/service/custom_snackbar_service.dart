import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbarService {
  static void error(
    dynamic err, {
    Duration? duration,
    bool closeAllPrevious = true,
  }) {
    if (closeAllPrevious) {
      while (Get.isSnackbarOpen == true) {
        Get.back();
      }
    }
    String errorMessage;
    if (err is DioException) {
      if (err.response != null) {
        errorMessage = err.response!.data.toString();
      } else {
        errorMessage = err.message!;
      }
    } else {
      errorMessage = err.toString();
    }
    Get.rawSnackbar(
      message: errorMessage,
      duration: duration ?? Duration(milliseconds: 1200),
      backgroundColor: Colors.red.shade700.withValues(alpha: 0.9),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: EdgeInsets.all(5),
      icon: Icon(Icons.error_outline, color: Colors.blueGrey.shade100),
      barBlur: 5,
      mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen == true) {
            Get.back();
          }
        },
        child: Text('Close', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static void info(
    String message, {
    Duration? duration,
    bool closeAllPrevious = true,
  }) {
    if (closeAllPrevious) {
      while (Get.isSnackbarOpen == true) {
        Get.back();
      }
    }
    Get.rawSnackbar(
      message: message,
      duration: duration ?? Duration(milliseconds: 1200),
      backgroundColor: Colors.blue.shade800.withValues(alpha: 0.7),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: EdgeInsets.all(5),
      icon: Icon(Icons.info, color: Colors.blueGrey.shade100),
      barBlur: 5,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void warning(
    String message, {
    Duration? duration,
    bool closeAllPrevious = true,
  }) {
    if (closeAllPrevious) {
      while (Get.isSnackbarOpen == true) {
        Get.back();
      }
    }
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 40.0),
      ),
      duration: duration ?? Duration(milliseconds: 1200),
      backgroundColor: Colors.amber.shade500.withValues(alpha: 0.7),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: EdgeInsets.all(5),
      icon: Icon(Icons.warning, color: Colors.blueGrey.shade900),
      barBlur: 5,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void success(
    String message, {
    Duration? duration,
    bool closeAllPrevious = true,
  }) {
    if (closeAllPrevious) {
      while (Get.isSnackbarOpen == true) {
        Get.back();
      }
    }
    Get.rawSnackbar(
      message: message,
      duration: duration ?? Duration(milliseconds: 1200),
      backgroundColor: Colors.green.shade700.withValues(alpha: 0.9),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: EdgeInsets.all(5),
      icon: Icon(Icons.check, color: Colors.blueGrey.shade100),
      barBlur: 5,
    );
  }
}
