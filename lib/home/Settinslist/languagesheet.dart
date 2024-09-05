import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class languagesheet extends StatefulWidget {
  const languagesheet({super.key});

  @override
  State<languagesheet> createState() => _languagesheetState();
}

class _languagesheetState extends State<languagesheet> {
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
