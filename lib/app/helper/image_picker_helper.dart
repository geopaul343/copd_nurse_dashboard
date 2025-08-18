
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

import 'package:permission_handler/permission_handler.dart';

import '../../ui/widgets/custom_snackBar.dart';

class FilePickerHandler {
  final ImagePicker _imagePicker = ImagePicker();

  // Future<bool> _requestPermission(Permission permission) async {
  //   final status = await permission.status;
  //   if (status.isGranted) {
  //     return true;
  //   } else if (status.isPermanentlyDenied) {
  //     SnackBarCustom.success("Please enable permission in settings");
  //     /// open app settings
  //     //openAppSettings();
  //     return false;
  //   } else {
  //     final result = await permission.request();
  //     if (!result.isGranted) {
  //       SnackBarCustom.success("Permission denied");
  //     }
  //     return result.isGranted;
  //   }
  // }

// Requests the specified permission from the user.
// Handles Android SDK 33+ where storage permission is split into `photos`.

  Future<bool> _requestPermission(Permission permission) async {
    try {
      if (permission == Permission.storage && Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        Permission targetPermission = (sdkInt >= 33)
            ? Permission.photos
            : Permission.storage;

        final status = await targetPermission.status;
        if (status.isGranted) {
          return true;
        } else if (status.isPermanentlyDenied) {
          SnackBarCustom.success("Please enable permission in settings");
         // await openAppSettings();
          return false;
        } else {
          final result = await targetPermission.request();
          if (!result.isGranted) {
            SnackBarCustom.success("Permission denied");
          }
          return result.isGranted;
        }
      }

      final status = await permission.status;
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        SnackBarCustom.success("Please enable permission in settings");
        await openAppSettings();
        return false;
      } else {
        final result = await permission.request();
        if (!result.isGranted) {
          SnackBarCustom.success("Permission denied");
        }
        return result.isGranted;
      }
    } catch (e) {
      SnackBarCustom.success("Error checking permission: $e");
      return false;
    }
  }

// Opens the image gallery and allows the user to pick an image.
// Returns a File object if an image is selected.

  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      // Handle error if necessary
    }
    return null;
  }

// Captures an image using the camera after requesting camera permission.
// Returns a File object if an image is captured.

  Future<File?> pickImageFromCamera() async {
    try {
      bool hasPermission = await _requestPermission(Permission.camera);
      if (!hasPermission) {
        // You might want to show a message to the user
        return null;
      }
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      // Handle error if necessary
    }
    return null;
  }

// Opens the video gallery and allows the user to pick a video.
// Returns a File object if a video is selected.

  Future<File?> pickVideoFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      // Handle error if necessary
    }
    return null;
  }

// Captures a video using the camera.
// Returns a File object if a video is captured.

  Future<File?> pickVideoFromCamera() async {
    try {
      final pickedFile = await _imagePicker.pickVideo(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      // Handle error if necessary
    }
    return null;
  }

// Allows the user to pick a PDF or JPEG file from storage after requesting permission.
// Returns the selected file as a File object.

  Future<File?> pickPdfOrJpeg() async {
    try {
      bool hasPermission = await _requestPermission(Permission.storage);
      if (!hasPermission) {
        // You might want to show a message to the user
        return null;
      }
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false, // Changed from true to false
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf'],
      );

      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        return File(pickedFile.files.first.path!); // Safely access the first file
      }
    } catch (e) {
      print('Error picking file: $e'); // Added error logging
    }
    return null;
  }

// Returns a formatted string of the file size, such as "1.23 Mb".
// Returns "N/A" if the file is null or does not exist.
  Future<String> getFileSize(File? file) async {
    if (file == null || !await file.exists()) return "N/A";
    int sizeInBytes = await file.length();
    return formatFileSize(sizeInBytes);
  }

// Converts the file size in bytes into a human-readable string.
// Example: 1024 -> "1.00 Kb"
  String formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "Kb", "Mb", "Gb", "Tb"];
    int i = (log(bytes) / log(1024)).floor(); // Use log from dart:math
    double size = bytes / pow(1024, i); // Use pow from dart:math
    return "${size.toStringAsFixed(2)} ${suffixes[i]}";
  }

}
