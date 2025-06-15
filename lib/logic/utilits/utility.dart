import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../presentation/widgets/custom_text.dart';

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

  static void errorSnackBar(BuildContext context, String errorMsg,
      [Color textColor = redColor, int duration = 2500]) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: duration),
          content: CustomText(
              text: errorMsg,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: textColor),
        ),
      );
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

    static double vPadding({double size = 20.0}) {
    return size;
  }

  static double hPadding({double size = 20.0}) {
    return size;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius;
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }
}
