import 'package:flutter/material.dart';


class KeyboardDissmisable extends StatefulWidget {
  const KeyboardDissmisable({super.key,required this.child});

  final Widget child;

  @override
  State<KeyboardDissmisable> createState() => _KeyboardDissmisableState();
}

class _KeyboardDissmisableState extends State<KeyboardDissmisable> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: widget.child,
    );
  }
}
