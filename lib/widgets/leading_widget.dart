import 'package:flutter/material.dart';

import '../configs/app_dimensions.dart';
import '../utils/routes.dart';

class LeadingWidget extends StatelessWidget {
  const LeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      return const SizedBox();
    } else {
      return InkWell(
        onTap: () => AppRoutes.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: AppDimensions.font(12),
        ),
      );
    }
  }
}
