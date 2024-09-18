import 'dart:math' as math;

import 'package:flutter/material.dart';

extension WidgetExtention on Widget {
  Widget rotate({double? degrees}) {
    if (degrees == null) return this; // If degrees is null, return the original widget

    // Convert degrees to radians
    double radians = degrees * (math.pi / 180.0);

    return Transform.rotate(angle: radians, child: this);
  }

  // Widget localeWithRotate({String? locale = "en"}) {
  //   return Transform.rotate(angle: (locale == LocaleUtils.localeEnglish.languageCode) ? 0 : math.pi, child: this);
  // }
}
