import "package:flutter/material.dart";

import "app_dimensions.dart";
import "ui.dart";

extension SuperEdgeInsets on EdgeInsets {
  EdgeInsets sv() => copyWith(
        top: top + UI.padding!.top,
        bottom: bottom + UI.padding!.bottom,
      );

  EdgeInsets st() => copyWith(top: top + UI.padding!.top);

  EdgeInsets sb() => copyWith(bottom: bottom + UI.padding!.bottom);

  EdgeInsets b(double no) => copyWith(bottom: AppDimensions.space(no));

  EdgeInsets t(double no) => copyWith(top: AppDimensions.space(no));

  EdgeInsets l(double no) => copyWith(left: AppDimensions.space(no));

  EdgeInsets r(double no) => copyWith(right: AppDimensions.space(no));
}
