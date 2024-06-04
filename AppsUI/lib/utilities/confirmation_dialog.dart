// Flutter imports:
import 'package:flutter/material.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

// Project imports

enum DialogAction { yes, abort }

class ConfirmationDialog {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.kContentColorDarkTheme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: Text(
                'No',
                style: TextStyle(color: AppColor.bgSideMenu),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: Text(
                'Yes',
                style: TextStyle(
                  color: AppColor.kErrorColor,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
