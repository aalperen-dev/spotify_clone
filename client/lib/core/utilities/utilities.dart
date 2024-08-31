import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AppUtilities {
  static void showSnackBar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
        ),
      );
  }

  static Future<File?> pickAudio() async {
    try {
      final filePickerRes =
          await FilePicker.platform.pickFiles(type: FileType.audio);
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<File?> pickImage() async {
    try {
      final filePickerRes =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
