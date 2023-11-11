import "package:flutter/material.dart";

import "app_dimensions.dart";
import "app_typography.dart";
import "space.dart";
import "ui.dart";

class App {
  App();
  static bool? isLtr;
  static bool showAds = false;

  static void init(BuildContext context) {
    UI.init(context);
    AppDimensions.init();

    Space.init();
    AppText.init();
    isLtr = Directionality.of(context) == TextDirection.ltr;
  }
}
