import 'dart:ui';

import 'package:flutter/material.dart';

class System {
  static double get width {
    return window.physicalSize.width / window.devicePixelRatio;
  }

  static double get height {
    return window.physicalSize.height / window.devicePixelRatio;
  }

}