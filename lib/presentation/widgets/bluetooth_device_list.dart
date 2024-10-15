import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class Rectangle12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      children: [
        Container(
          width: 304,
          height: 449,
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const BluetoothManager(),
        ),
      ],
    );
  }
}

class BluetoothManager extends StatefulWidget {
  const BluetoothManager({super.key});

  @override
  _BluetoothManagerState createState() => _BluetoothManagerState();
}

class _BluetoothManagerState extends State<BluetoothManager> {
  List<BluetoothDevice> connectedDevices = [];
  List<ScanResult> scanResults = [];
  BluetoothDevice? _selectedDevice;
  bool isConnected = false;
  BluetoothCharacteristic? _characteristic;

  @override
  void initState() {
    super.initState();
    _fetchConnectedDevices();
  }

  void _fetchConnectedDevices() async {
    var devices = await FlutterBluePlus.connectedDevices;
    setState(() {
      connectedDevices = devices;
    });
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
        isConnected = true;
      });
      _discoverServices(device);
      print('Connected to ${device.name}');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }

  Future<void> _discoverServices(BluetoothDevice device) async {
    var services = await device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() ==
              "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
            _characteristic = characteristic;
            _subscribeToCharacteristic();
          }
        }
      }
    }
  }

  void _subscribeToCharacteristic() {
    _characteristic?.value.listen((value) {
      String status = String.fromCharCodes(value);
      if (status == "connected") {
        setState(() {
          isConnected = true;
        });
      } else if (status == "disconnected") {
        setState(() {
          isConnected = false;
        });
      }
    });
    _characteristic?.setNotifyValue(true);
  }

  Future<void> _disconnectFromDevice() async {
    if (_selectedDevice != null) {
      await _selectedDevice!.disconnect();
      setState(() {
        _selectedDevice = null;
        isConnected = false;
      });
      print('Disconnected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _startScan,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
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
                    color: isConnected && result.device == _selectedDevice
                        ? Colors.green
                        : Colors.black,
                    fontFamily: GoogleFonts.notoSans().fontFamily,
                  ),
                ),
                subtitle: Text(result.device.id.toString()),
                trailing: isConnected && result.device == _selectedDevice
                    ? const Icon(Icons.bluetooth_connected)
                    : const Icon(Icons.bluetooth),
                onTap: () {
                  if (isConnected && result.device == _selectedDevice) {
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
