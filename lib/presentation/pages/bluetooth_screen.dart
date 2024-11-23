import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/presentation/pages/root_screen.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  void showDeviceManagementDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: defaultBG,
        contentPadding: const EdgeInsets.all(16),
        content: SizedBox(
          height: 500,
          child: Column(
            children: [
              Expanded(
                child: Rectangle12(),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: BluetoothManager.isConnectedNotifier,
                builder: (context, isConnected, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: isConnected
                        ? () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const RootScreen()),
                            );
                          }
                        : null,
                    child: Text(
                      isConnected ? '확인' : '연결 대기 중...',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
                const SizedBox(height: 16),
                Text(
                  "장치와 연결되지 않았습니다.",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
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
            onPressed: () => showDeviceManagementDialog(context),
            child: const Text('장치 관리'),
          ),
        ],
      ),
    );
  }
}

class Rectangle12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      width: 304,
      height: 449,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: const BluetoothManager(),
    );
  }
}

class BluetoothManager extends StatefulWidget {
  const BluetoothManager({super.key});

  static final ValueNotifier<bool> isConnectedNotifier =
      ValueNotifier<bool>(false);
  @override
  _BluetoothManagerState createState() => _BluetoothManagerState();
}

class _BluetoothManagerState extends State<BluetoothManager> {
  List<ScanResult> scanResults = [];
  BluetoothDevice? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        _selectedDevice = device;
      });
      BluetoothManager.isConnectedNotifier.value = true;
      print('Connected to ${device.name}');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }

  Future<void> _disconnectFromDevice() async {
    if (_selectedDevice != null) {
      await _selectedDevice!.disconnect();
      setState(() {
        _selectedDevice = null;
      });
      BluetoothManager.isConnectedNotifier.value = false;
      print('Disconnected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _startScan,
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            '장치 검색하기',
            style: textTheme.bodyLarge?.copyWith(
              fontFamily: GoogleFonts.notoSans().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '사용 가능한 기기:',
          style: textTheme.titleMedium?.copyWith(
            fontFamily: GoogleFonts.notoSans().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView(
            children: scanResults.map((result) {
              return ListTile(
                title: Text(
                  result.device.name.isNotEmpty
                      ? result.device.name
                      : 'Unknown Device',
                  style: TextStyle(
                    color: BluetoothManager.isConnectedNotifier.value &&
                            result.device == _selectedDevice
                        ? Colors.green
                        : Colors.black,
                    fontFamily: GoogleFonts.notoSans().fontFamily,
                  ),
                ),
                subtitle: Text(result.device.id.toString()),
                trailing: BluetoothManager.isConnectedNotifier.value &&
                        result.device == _selectedDevice
                    ? const Icon(Icons.bluetooth_connected)
                    : const Icon(Icons.bluetooth),
                onTap: () {
                  if (BluetoothManager.isConnectedNotifier.value &&
                      result.device == _selectedDevice) {
                    _disconnectFromDevice();
                  } else {
                    _connectToDevice(result.device);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
