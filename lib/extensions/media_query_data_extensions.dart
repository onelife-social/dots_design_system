import 'dart:ui';
import 'package:flutter/material.dart';

extension MediaQueryDataExtensions on MediaQueryData {
  double get aspectRatio {
    
    final FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    final Size realSize = view.display.size;

    final physicalWidth = realSize.width / devicePixelRatio;
    final physicalHeight = realSize.height / devicePixelRatio;

    final physicalAspectRatioHeight = (physicalHeight / physicalWidth) * 9;

    return physicalAspectRatioHeight;
  }
}
  