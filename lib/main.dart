import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'widgets/app_drawer.dart';
import 'screens/rules_screen.dart';
import 'screens/mic_screen.dart';
import 'package:provider/provider.dart';
import 'providers/font_size_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
      ],
      child: const SmartWasteApp(),
    ),
  );
}


class SmartWasteApp extends StatelessWidget {
  const SmartWasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Waste Sorting',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLocation = 'Berlin';
  String _selectedLanguage = 'English';

  final ImagePicker picker = ImagePicker();

  void _onLocationChanged(String location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _onLanguageChanged(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _onFontSizeChanged(double fontSize) {
    context.read<FontSizeProvider>().setFontSize(fontSize);
  }

  Future<void> pickFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RulesScreen(initialImage: imageFile),
        ),
      );
    } else {
      print("❌ No image captured.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fontSize;

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Waste Sorting', style: TextStyle(fontSize: fontSize)),
      ),
      drawer: AppDrawer(
        onLocationChanged: _onLocationChanged,
        onLanguageChanged: _onLanguageChanged,
        onFontSizeChanged: _onFontSizeChanged,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt, size: 60),
              onPressed: pickFromCamera,
            ),
            const SizedBox(height: 30),
            IconButton(
              icon: const Icon(Icons.mic, size: 50),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpeechScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
