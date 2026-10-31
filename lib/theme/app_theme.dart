import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppColors {
  static const orange = Color(0xFFCC4A04);
  static const orangeTint = Color(0xFFFFF3EA);
  static const orangeLine = Color(0xFFF5D8C4);
  static const ink = Color(0xFF231B16);
  static const muted = Color(0xFF74665C);
  static const line = Color(0xFFEAE3DD);
  static const danger = Color(0xFFB42318);
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
}

class AppLayout {
  static const maxContentWidth = 640.0;
  static const minGutter = 20.0;

  static double gutter(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return math.max(minGutter, (width - maxContentWidth) / 2);
  }
}

const tabularFigures = [FontFeature.tabularFigures()];
