import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/font_size_provider.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onLocationChanged;
  final Function(String) onLanguageChanged;
  final Function(double) onFontSizeChanged;

  const AppDrawer({
    super.key,
    required this.onLocationChanged,
    required this.onLanguageChanged,
    required this.onFontSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = context.watch<FontSizeProvider>();
    double fontSize = fontSizeProvider.fontSize;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Change Location'),
            onTap: () {
              onLocationChanged("New Location");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Change Language'),
            onTap: () {
              onLanguageChanged("German");
              Navigator.pop(context);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Font Size", style: TextStyle(fontWeight: FontWeight.bold)),
                Slider(
                  value: fontSize,
                  min: 12.0,
                  max: 28.0,
                  divisions: 8,
                  label: fontSize.toStringAsFixed(0),
                  onChanged: (value) {
                    fontSizeProvider.setFontSize(value);
                    onFontSizeChanged(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
