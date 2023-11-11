import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  const AsyncButton({super.key, required this.child, required this.onPressed});
  final Widget child;
  final Function() onPressed;
  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  final ValueNotifier<bool> _valueNotifier = ValueNotifier(false);

  _onTap() async {
    _valueNotifier.value = true;
    await widget.onPressed();
    _valueNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return InkWell(
          onTap: value
              ? null
              : () {
                  _onTap();
                },
          child: value
              ?

              ///
              /// Can customise it if needed
              ///
              const CircularProgressIndicator()
              : widget.child,
        );
      },
    );
  }
}
