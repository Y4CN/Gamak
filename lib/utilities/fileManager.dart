import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

class FileManager {
  FileManager._();
  static Future<Either<String, File>> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      return Right(file);
    } else {
      return const Left('فایل به مشکل خورده است');
    }
  }
}
