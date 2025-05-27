import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class TypographyDemoPage extends StatefulWidget {
  const TypographyDemoPage({super.key});

  @override
  State<TypographyDemoPage> createState() => _TypographyStatePage();
}

class _TypographyStatePage extends State<TypographyDemoPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String inputText = "Ejemplo de texto";

  DotsTypoMainModel get mainModel => context.dotsTheme.typo.main;

  DotsTypoNumberModel get numberModel => context.dotsTheme.typo.number;

  DotsTypoSecondaryModel get secondaryModel => context.dotsTheme.typo.secondary;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget buildTextList(Map<String, TextStyle> styles) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: styles.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('${entry.key}: $inputText', style: entry.value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainStyles = {
      'titleH1': mainModel.titleH1,
      'titleH2': mainModel.titleH2,
      'titleH3': mainModel.titleH3,
      'titleH4': mainModel.titleH4,
      'titleH5': mainModel.titleH5,
      'titleH6': mainModel.titleH6,
      'bodyLargeRegular': mainModel.bodyLargeRegular,
      'bodyLargeMedium': mainModel.bodyLargeMedium,
      'bodyLargeBold': mainModel.bodyLargeBold,
      'bodyDefaultRegular': mainModel.bodyDefaultRegular,
      'bodyDefaultMedium': mainModel.bodyDefaultMedium,
      'bodyDefaultBold': mainModel.bodyDefaultBold,
      'labelDefaultRegular': mainModel.labelDefaultRegular,
      'labelDefaultBold': mainModel.labelDefaultBold,
      'labelSmallRegular': mainModel.labelSmallRegular,
      'labelSmallMedium': mainModel.labelSmallMedium,
    };

    final numberStyles = {
      'numTitleH1': numberModel.numTitleH1,
      'numTitleH2': numberModel.numTitleH2,
      'numTitleH3': numberModel.numTitleH3,
      'numTitleH4': numberModel.numTitleH4,
      'numTitleH5': numberModel.numTitleH5,
      'numTitleH6': numberModel.numTitleH6,
      'numBodyLarge': numberModel.numBodyLarge,
      'numBodyDefault': numberModel.numBodyDefault,
      'numLabelDefault': numberModel.numLabelDefault,
      'numLabelSmall': numberModel.numLabelSmall,
    };

    final secondaryStyles = {
      'title02H1': secondaryModel.title02H1,
      'title02H2': secondaryModel.title02H2,
      'title02H3': secondaryModel.title02H3,
      'title02H4': secondaryModel.title02H4,
      'title02H5': secondaryModel.title02H5,
      'title02H6': secondaryModel.title02H6,
    };

    return Scaffold(
      backgroundColor: context.dotsTheme.colors.bgBase,
      appBar: AppBar(
        title: Text(
          'Demo Tipografía',
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Main'),
            Tab(text: 'Number'),
            Tab(text: 'Secondary'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Texto de ejemplo',
              ),
              onChanged: (value) => setState(() => inputText = value),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildTextList(mainStyles),
                buildTextList(numberStyles),
                buildTextList(secondaryStyles),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
