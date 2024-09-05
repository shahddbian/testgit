import 'package:flutter/material.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class themesheet extends StatefulWidget {
  @override
  State<themesheet> createState() => _themesheetState();
}

class _themesheetState extends State<themesheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                provider.changetheme(ThemeMode.light);
              },
              child: provider.appMode == ThemeMode.light
                  ? getSelectedItemwidget(AppLocalizations.of(context)!.light)
                  : getUnSelectedwidget(AppLocalizations.of(context)!.light),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                provider.changetheme(ThemeMode.dark);
              },
              child: provider.appMode == ThemeMode.dark
                  ? getSelectedItemwidget(AppLocalizations.of(context)!.dark)
                  : getUnSelectedwidget(AppLocalizations.of(context)!.dark),
            ),
          )
        ],
      ),
    );
  }

  Widget getSelectedItemwidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: TextStyle(
                    fontSize: 18,
                    color: appcolors.blackColor,
                    fontWeight: FontWeight.w400)
                ?.copyWith(color: appcolors.primaryColor)),
        Icon(
          Icons.check,
          size: 30,
          color: appcolors.primaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedwidget(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: appcolors.blackColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
