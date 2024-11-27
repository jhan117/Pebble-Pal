import 'package:flutter/material.dart';
import 'package:graytalk/presentation/widgets/lighting_ui.dart';
import 'package:graytalk/presentation/widgets/lighting_controller.dart';

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
                    lightingController.saveCurrentColor(context, () {
                      setState(() {});
                    });
                  },
                  child: const Text("색상 저장"),
                ),
                ElevatedButton(
                  onPressed: () {
                    lightingController.deleteCurrentColor(context, () {
                      setState(() {});
                    });
                  },
                  child: const Text("색상 삭제"),
                ),
                ElevatedButton(
                  onPressed: () {},
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
