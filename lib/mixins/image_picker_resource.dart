import 'dart:io';

import 'package:image_picker/image_picker.dart';

mixin ImagePickerResource {
  File? file;

  Future<File?> getImagePicked(
      {ImageSource source = ImageSource.gallery}) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      file = File(image.path);
    }

    return file;
  }
}
