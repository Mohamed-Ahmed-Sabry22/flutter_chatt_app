import 'package:flutter/material.dart';

class Snackbar extends StatelessWidget {
  const Snackbar({super.key, required this.snackBarText});
  final String snackBarText;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: Text(snackBarText),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    return const SizedBox.shrink();
  }
}
