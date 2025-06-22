import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// Classify image on mobile using image path
Future<String> classifyImage(File imageFile) async {
  final uri = Uri.parse('https://my-waste-api.onrender.com'); // ✅ Use HTTPS

  var request = http.MultipartRequest('POST', uri);
  request.files.add(await http.MultipartFile.fromPath('file', imageFile.path)); // ✅ 'file' matches FastAPI

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final jsonData = json.decode(respStr);
      return jsonData['class'] ?? 'Unknown';
    } else {
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    return 'Exception: $e';
  }
}

/// Classify image on web using base64
Future<String> classifyImageWeb(Uint8List imageBytes) async {
  final uri = Uri.parse("https://my-waste-api.onrender.com");

  final request = http.MultipartRequest('POST', uri);
  request.files.add(
    http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: 'image.jpg',
    ),
  );

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    final decoded = jsonDecode(responseBody);
    return decoded['class'];
  } else {
    throw Exception("Prediction failed (${response.statusCode})");
  }
}