import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  XFile? selectedImage;

  Future<XFile?> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 20,
    );

    selectedImage = pickedFile;
    return pickedFile;
  }

  void clearImage() {
    selectedImage = null;
  }

  Future<void> showImageSourceDialog({
    required BuildContext context,
    required Function(XFile? image) onImagePicked,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);

                final image = await pickImage(ImageSource.gallery);
                onImagePicked(image);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);

                final image = await pickImage(ImageSource.camera);
                onImagePicked(image);
              },
            ),
          ],
        ),
      ),
    );
  }
}