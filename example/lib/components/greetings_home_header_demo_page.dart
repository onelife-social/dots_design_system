import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class GreetingsHomeHeaderDemoPage extends StatelessWidget {
  const GreetingsHomeHeaderDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GreetingsHomeHeader(
          titleText: 'Hola Carlos,',
          subtitleText: 'Tienes 6 álbumes con nuevos memories',
        ),
      ],
    );
  }
}
