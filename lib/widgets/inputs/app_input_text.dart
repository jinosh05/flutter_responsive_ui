import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../constants/resources.dart';
import '../../utils/regex_pattern.dart';

class AppInputText extends StatelessWidget {
  const AppInputText({
    super.key,
    this.suffixIcon,
    this.ctrl,
    required this.hint,
    this.label,
    this.type = AppInputType.alphanumeric,
    this.visible = true,
    this.enabled = true,
    this.blackLabel = false,
    this.helper,
  });
  final Widget? suffixIcon;
  final TextEditingController? ctrl;
  final String hint;
  final String? label, helper;
  final AppInputType type;
  final bool enabled, visible, blackLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(
        AppDimensions.normalize(3),
      ),
      child: TextFormField(
        controller: ctrl,
        keyboardType: getKeyboard(),
        inputFormatters: type != AppInputType.integer
            ? null
            : [
                // for version 2 and greater youcan also use this
                FilteringTextInputFormatter.digitsOnly,
              ],
        validator: (value) {
          if (value == null) {
            return S.cantEmpty;
          } else if (value.isEmpty) {
            return S.cantEmpty;
          } else if (type == AppInputType.email &&
              !RegVal.hasMatch(value, RegexPattern.email)) {
            return S.invalidEMail;
          } else if (type == AppInputType.password &&
              !RegVal.hasMatch(value, RegexPattern.passwordEasy)) {
            return S.invalidPassword;
          } else if (type == AppInputType.integer &&
              !RegVal.hasMatch(value, RegexPattern.numericOnly)) {
            return S.invalidNumber;
          } else if (type == AppInputType.website &&
              Uri.tryParse("https://$value")!.hasAbsolutePath &&
              !value.startsWith("https://") &&
              !value.startsWith("http://")) {
            log("https://$value");
            return S.invalidURL;
          }
          return null;
        },
        obscureText: !visible,
        decoration: InputDecoration(
          isDense: true,
          enabled: enabled,
          hintText: hint,
          contentPadding: Space.all(1, 0.6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.normalize(3),
            ),
          ),
          suffixIcon: suffixIcon,
          helperText: helper,
          helperStyle: AppText.b3!.w(3),
        ),
      ),
    );
  }

  TextInputType getKeyboard() {
    if (type == AppInputType.email) {
      return TextInputType.emailAddress;
    }
    if (type == AppInputType.password) {
      return TextInputType.visiblePassword;
    }
    if (type == AppInputType.integer) {
      return TextInputType.number;
    }
    if (type == AppInputType.website) {
      return TextInputType.url;
    }

    return TextInputType.text;
  }
}

enum AppInputType {
  username,
  email,
  password,
  integer,
  alphanumeric,
  website,
}
