import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class LightingBluetooth {
  final BluetoothCharacteristic targetCharacteristic;

  LightingBluetooth({required this.targetCharacteristic});

  Future<void> sendRGB(int r, int g, int b) async {
    String rgbValue = "$r,$g,$b";
    await targetCharacteristic.write(
      rgbValue.codeUnits,
      withoutResponse: false,
    );
  }

  Future<void> turnOffLED() async {
    await targetCharacteristic.write(
      "0".codeUnits,
      withoutResponse: false,
    );
  }

  Future<void> sendCommandTwo() async {
    try {
      await targetCharacteristic.write(
        "2".codeUnits,
        withoutResponse: false,
      );
      print("Command 2 sent to BLE device");
    } catch (e) {}
  }
}
