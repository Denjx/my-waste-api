import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      // predict API ဆီ ပို့ရန် function
      await predictImage(_image!);
    }
  }

  Future<void> predictImage(File image) async {
    // api_service.dart ထဲက function ခေါ်လို့ရ
    // ဒါမှမဟုတ် ဒီမှာ http.MultipartRequest လုပ်လို့ရ
    print("Send to FastAPI backend: ${image.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : Text("No image selected."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Take Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
