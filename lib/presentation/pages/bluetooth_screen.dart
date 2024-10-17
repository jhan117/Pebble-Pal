import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/core/theme/fonts.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final String deviceName = "DORI";
  final String targetServiceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String impactSensorUUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();

      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService srv in services) {
        if (srv.uuid.toString() == targetServiceUUID) {
          for (BluetoothCharacteristic char in srv.characteristics) {
            if (char.uuid.toString() == impactSensorUUID) {
              // 알림 설정
              char.lastValueStream.listen((value) {
                print('Read value: $value');
              });
              await char.setNotifyValue(true);
            }
          }
        }
      }
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  Future<void> startScanAndConnect() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.platformName == deviceName) {
          connectToDevice(r.device);
          break;
        }
      }
    });

    FlutterBluePlus.stopScan();
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: defaultBG,
        content: SizedBox(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "연결중...",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );

    startScanAndConnect();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: defaultBG,
      padding: const EdgeInsets.fromLTRB(16, 120, 16, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset(
                  "assets/imgs/intro/stone_friend.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "장치와 연결되지 않았습니다.",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "장치의 전원이 켜져 있는지 확인하고 Bluetooth를 통해 장치를 연결하십시오.",
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () => showLoadingDialog(context),
            child: const Text('연결'),
          ),
        ],
      ),
    );
  }
}
