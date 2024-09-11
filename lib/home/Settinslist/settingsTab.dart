import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/home/Settinslist/themesheet.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'package:todoapp/home/Settinslist/languagesheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var theme = Theme.of(context);

    return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.language,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: appcolors.primaryColor, width: 2)),
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 22)),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(AppLocalizations.of(context)!.mode,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: appcolors.primaryColor, width: 2)),
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 22)),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ],
        ));
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

