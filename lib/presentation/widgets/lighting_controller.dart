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

  void updateBrightness(double value) {
    brightness = value;
    saveBrightness();
  }

  void saveCurrentColor() {
    if (savedColors.length < maxColors &&
        !savedColors.any((color) => color.value == currentColor.value)) {
      savedColors.add(currentColor);
      saveColorsToPreferences();
    }
  }

  void deleteCurrentColor() {
    savedColors.removeWhere((color) => color.value == currentColor.value);
    saveColorsToPreferences();
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
