import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LightingController {
  Color currentColor = Colors.blue;
  double brightness = 1.0;
  final TextEditingController hexController = TextEditingController();
  List<Color> savedColors = [];
  final int maxColors = 10;

  Future<void> init() async {
    hexController.text =
        "#${currentColor.value.toRadixString(16).substring(2).toUpperCase()}";
    await loadSavedColors();
    await loadBrightness();
  }

  void dispose() {
    hexController.dispose();
  }

  Future<void> loadSavedColors() async {
    final prefs = await SharedPreferences.getInstance();
    final colorStrings = prefs.getStringList('savedColors') ?? [];
    savedColors = colorStrings
        .map((colorString) => Color(int.parse(colorString)))
        .toList();
  }

  Future<void> saveColorsToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorStrings =
        savedColors.map((color) => color.value.toRadixString(16)).toList();
    await prefs.setStringList('savedColors', colorStrings);
  }

  Future<void> loadBrightness() async {
    final prefs = await SharedPreferences.getInstance();
    brightness = prefs.getDouble('brightness') ?? 1.0;
  }

  Future<void> saveBrightness() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('brightness', brightness);
  }

  void saveCurrentColor(BuildContext context, VoidCallback onSaved) {
    if (savedColors.length >= maxColors) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("최대 $maxColors개의 색상만 저장할 수 있습니다.")),
      );
      return;
    }
    if (!savedColors.any((color) => color.value == currentColor.value)) {
      savedColors.add(currentColor);
      saveColorsToPreferences();
      onSaved();
    }
  }

  void deleteCurrentColor(BuildContext context, VoidCallback onDeleted) {
    if (savedColors.any((color) => color.value == currentColor.value)) {
      savedColors.removeWhere((color) => color.value == currentColor.value);
      saveColorsToPreferences();
      onDeleted();
    }
  }

  void updateBrightness(double value) {
    brightness = value;
    saveBrightness();
  }

  void updateColorFromHex(String hex) {
    try {
      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.length == 6 || hex.length == 8) {
        currentColor = Color(int.parse("FF$hex", radix: 16));
      }
    } catch (e) {
      print("Invalid HEX code: $hex");
    }
  }
}
