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
          await FilePicker.platform.pickFiles(type: FileType.media);
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static String rgbToHex({required Color color}) {
    return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  static Color hexToColor({required String hex}) {
    return Color(int.parse(hex, radix: 16) + 0xFF000000);
  }
}
