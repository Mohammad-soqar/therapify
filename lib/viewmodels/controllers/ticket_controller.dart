import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  List<File> selectedFiles = [];

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
      );
      if (result != null) {
        selectedFiles = result.files.map((file) => File(file.path!)).toList();
        update();
      } else {
        // User canceled the picker
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
    }
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
    update();
  }
}
