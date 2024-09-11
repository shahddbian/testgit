import 'package:flutter/material.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Themesheet extends StatefulWidget {
  @override
  State<Themesheet> createState() => _ThemesheetState();
}

class _ThemesheetState extends State<Themesheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var theme = Theme.of(context);

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
                  ? getSelectedItemwidget(
                      AppLocalizations.of(context)!.light, theme)
                  : getUnSelectedwidget(
                      AppLocalizations.of(context)!.light, theme),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                provider.changetheme(ThemeMode.dark);
              },
              child: provider.appMode == ThemeMode.dark
                  ? getSelectedItemwidget(
                      AppLocalizations.of(context)!.dark, theme)
                  : getUnSelectedwidget(
                      AppLocalizations.of(context)!.dark, theme),
            ),
          )
        ],
      ),
    );
  }

  Widget getSelectedItemwidget(String text, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: appcolors.primaryColor)),
        Icon(
          Icons.check,
          size: 30,
          color: appcolors.primaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedwidget(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium,
    );
  }
}
