import 'package:flutter/material.dart';

class WasteResultCard extends StatelessWidget {
  final String category;

  const WasteResultCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final binColor = _getColorForCategory(category);
    final binHint = _getHintForCategory(category);

    return Card(
      color: binColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: binColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              binHint,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'plastic':
        return Colors.orange;
      case 'organic':
        return Colors.green;
      case 'metal':
        return Colors.grey;
      case 'paper':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  String _getHintForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'plastic':
        return 'Dispose in the orange recycling bin ♻️';
      case 'organic':
        return 'Dispose in the green compost bin 🌱';
      case 'metal':
        return 'Dispose in the metal scrap area 🏗️';
      case 'paper':
        return 'Dispose in the blue paper bin 📘';
      default:
        return 'Dispose properly.';
    }
  }
}
