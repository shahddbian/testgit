import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/home/Settinslist/themesheet.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'languagesheet.dart';
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
    return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: appcolors.whiteColor,
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
                        style: TextStyle(
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: appcolors.whiteColor,
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
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 22)),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void showlanguagesheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: appcolors.primaryColor,
              width: 2,
            )),
        context: context,
        builder: (context) => languagesheet());
  }

  void showthemesheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: appcolors.primaryColor,
              width: 2,
            )),
        context: context,
        builder: (context) => themesheet());
  }
}
