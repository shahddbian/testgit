import 'package:flutter/material.dart';

class dialogutils {
  static void showLoading(
      {required BuildContext context,
      required String LoadingLabel,
      bool barrierDismissible = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  LoadingLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showsms(
      {required BuildContext context,
      required String content,
      String title = 'Title',
      String? postiveActionname,
      Function? posAction,
      String? regActionname,
      Function? Negaction}) {
    List<Widget> actions = [];

    if (postiveActionname != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(postiveActionname),
        ),
      );
    }

    if (regActionname != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Negaction?.call();
          },
          child: Text(regActionname),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          title: Text(title),
          actions: actions, // هنا يتم إضافة القائمة إلى الـ AlertDialog
        );
      },
    );
  }
}
