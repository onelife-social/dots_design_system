import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class CountdownEventFinishedDemoPage extends StatefulWidget {
  const CountdownEventFinishedDemoPage({super.key});
  @override
  State<CountdownEventFinishedDemoPage> createState() => _CountdownEventFinishedDemoPageState();
}

class _CountdownEventFinishedDemoPageState extends State<CountdownEventFinishedDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.dotsTheme.colors.bgContainerSecondary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 10,
            child: Center(
              child: CountdownEventFinished(),
            ),
          ),
        ],
      ),
    );
  }
}
