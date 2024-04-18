
import 'package:flutter/material.dart';

class Utils {
  static loadingDialog(BuildContext context,
      {bool barrierDismissible = false, String message = ''}) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 15),
            Text(message)
          ],
        )),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }
  static void showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
