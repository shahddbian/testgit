import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'themesheet.dart';

class Languagesheet extends StatefulWidget {
  @override
  State<Languagesheet> createState() => _LanguagesheetState();
}

class _LanguagesheetState extends State<Languagesheet> {
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
                provider.changelanguage('en');
              },
              child: provider.applanguage == 'en'
                  ? getSelectedItemwidget(AppLocalizations.of(context)!.english)
                  : getUnSelectedwidget(AppLocalizations.of(context)!.english),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                provider.changelanguage('ar');
              },
              child: provider.applanguage == 'ar'
                  ? getSelectedItemwidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedwidget(AppLocalizations.of(context)!.arabic),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemwidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appcolors.primaryColor),
        ),
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
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

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
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemwidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appcolors.primaryColor),
        ),
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
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class settingsTab extends StatefulWidget {
  @override
  State<settingsTab> createState() => _settingsTabState();
}

class _settingsTabState extends State<settingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: appcolors.primaryColor, width: 2),
            ),
            child: InkWell(
              onTap: () {
                showlanguagesheet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.applanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: Theme.of(context).textTheme.bodyMedium?.color)
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: appcolors.primaryColor, width: 2),
            ),
            child: InkWell(
              onTap: () {
                showthemesheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appMode == ThemeMode.light
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: Theme.of(context).textTheme.bodyMedium?.color)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showthemesheet() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: appcolors.primaryColor,
          width: 2,
        ),
      ),
      context: context,
      builder: (context) => Themesheet(),
    );
  }

  void showlanguagesheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: appcolors.primaryColor,
          width: 2,
        ),
      ),
      context: context,
      builder: (context) => Languagesheet(),
    );
  }
}
