import 'package:flutter/material.dart';

class Helper {
  static const func = _Function();
}

class _Function {
  const _Function();

  showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
