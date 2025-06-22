import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RulesScreen extends StatefulWidget {
  final File initialImage;

  const RulesScreen({Key? key, required this.initialImage}) : super(key: key);

  @override
  _RulesScreenState createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  String? _predictedClass;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _predictImage(widget.initialImage);
  }

  Future<void> _predictImage(File imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
     final uri = Uri.parse('https://my-waste-api.onrender.com/predict'); // 🔁 Use your actual IP
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);
        setState(() {
          _predictedClass = decoded['class'];
        });
      } else {
        setState(() {
          _predictedClass = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _predictedClass = "Failed to connect: $e";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prediction Result')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(widget.initialImage, height: 200),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_predictedClass != null)
                Text(
                  'Predicted Class: $_predictedClass',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              else
                const Text('No prediction yet.'),
            ],
          ),
        ),
      ),
    );
  }
}
