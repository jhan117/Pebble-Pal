import 'package:flutter/material.dart';
import 'package:graytalk/presentation/widgets/lighting_ui.dart';
import 'package:graytalk/presentation/widgets/lighting_controller.dart';
import 'package:graytalk/presentation/widgets/rgb_send.dart';
import 'package:graytalk/presentation/pages/bluetooth_screen.dart';

class LightingScreen extends StatefulWidget {
  const LightingScreen({super.key});

  @override
  State<LightingScreen> createState() => _LightingScreenState();
}

class _LightingScreenState extends State<LightingScreen> {
  final LightingController lightingController = LightingController();

  @override
  void initState() {
    super.initState();
    lightingController.init().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    lightingController.dispose();
    super.dispose();
  }

  Future<void> _sendRGBToDevice() async {
    if (BluetoothManager.targetCharacteristic != null) {
      final currentColor = lightingController.currentColor;
      final brightness = lightingController.brightness;

      int r = (currentColor.red * brightness).toInt();
      int g = (currentColor.green * brightness).toInt();
      int b = (currentColor.blue * brightness).toInt();

      final lightingBluetooth = LightingBluetooth(
        targetCharacteristic: BluetoothManager.targetCharacteristic!,
      );

      await lightingBluetooth.sendRGB(r, g, b);
    } else {
      print('No characteristic found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: LightingWidget(
                controller: lightingController,
                onSaved: () => setState(() {}),
                onDeleted: () => setState(() {}),
                onBrightnessChanged: () => setState(() {}),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    lightingController.saveCurrentColor();
                    setState(() {});
                  },
                  child: const Text("색상 저장"),
                ),
                ElevatedButton(
                  onPressed: () {
                    lightingController.deleteCurrentColor();
                    setState(() {});
                  },
                  child: const Text("색상 삭제"),
                ),
                ElevatedButton(
                  onPressed: _sendRGBToDevice,
                  child: const Text("LED 적용"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
