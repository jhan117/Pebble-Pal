import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'lighting_controller.dart';

class LightingWidget extends StatelessWidget {
  final LightingController controller;
  final VoidCallback onSaved;
  final VoidCallback onDeleted;
  final VoidCallback onBrightnessChanged;

  const LightingWidget({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onDeleted,
    required this.onBrightnessChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ColorPicker(
            pickerColor: controller.currentColor,
            onColorChanged: (color) {
              controller.currentColor = color;
              controller.hexController.text =
                  "#${color.value.toRadixString(16).substring(2).toUpperCase()}";
            },
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
            paletteType: PaletteType.hueWheel,
            labelTypes: const [],
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: controller.hexController,
          decoration: const InputDecoration(
            labelText: "HEX 코드",
            border: OutlineInputBorder(),
          ),
          onSubmitted: controller.updateColorFromHex,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: controller.savedColors
              .map(
                (color) => GestureDetector(
                  onTap: () {
                    controller.currentColor = color;
                    controller.hexController.text =
                        "#${color.value.toRadixString(16).substring(2).toUpperCase()}";
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 20,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
