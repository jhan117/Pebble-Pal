import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/fonts.dart';
import 'package:graytalk/features/light/widgets/lighting_ui.dart';
import 'package:graytalk/features/light/widgets/lighting_controller.dart';
import 'package:graytalk/features/light/widgets/rgb_send.dart';
import 'package:graytalk/features/bluetooth/screen/bluetooth_screen.dart';

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

  Future<void> _turnOffLED() async {
    if (BluetoothManager.targetCharacteristic != null) {
      final lightingBluetooth = LightingBluetooth(
        targetCharacteristic: BluetoothManager.targetCharacteristic!,
      );

      await lightingBluetooth.turnOffLED();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: bodyMedium,
                    ),
                    onPressed: () {
                      lightingController.saveCurrentColor();
                      setState(() {});
                    },
                    child: Text("저장", style: bodyMedium),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: bodyMedium,
                    ),
                    onPressed: () {
                      lightingController.deleteCurrentColor();
                      setState(() {});
                    },
                    child: Text("삭제", style: bodyMedium),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: bodyMedium,
                    ),
                    onPressed: _sendRGBToDevice,
                    child: Text("ON", style: bodyMedium),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: bodyMedium,
                    ),
                    onPressed: _turnOffLED,
                    child: Text("OFF", style: bodyMedium),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
