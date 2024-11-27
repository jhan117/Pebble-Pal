import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class LightingBluetooth {
  final BluetoothCharacteristic targetCharacteristic;

  LightingBluetooth({required this.targetCharacteristic});

  Future<void> sendRGB(int r, int g, int b) async {
    String rgbValue = "$r,$g,$b";
    await targetCharacteristic.write(rgbValue.codeUnits, withoutResponse: true);
  }
}
