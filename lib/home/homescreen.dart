import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/home/auth/login/loginscreen.dart';
import 'package:todoapp/provider/listprovider.dart';
import 'package:todoapp/provider/userprovider.dart';
import 'Settinslist/settingsTab.dart';
import 'Tasklist/AddBottomSheet.dart';
import 'Tasklist/tasklistTab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class homescreen extends StatefulWidget {
  static const String routeName = 'home screen';

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<Userprovider>(context);
    var listProvider = Provider.of<listprovider>(context);
    var theme = Theme.of(context);

    // التحكم في لون الـ NavigationBar بناءً على الثيم
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: theme.bottomAppBarColor,
    ));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
            selectedIndex == 0
                ? "{${AppLocalizations.of(context)!.app_title}${userProvider.currentUser!.name}}"
                : AppLocalizations.of(context)!.settings,
            style: theme.textTheme.bodyLarge),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasklist = [];
                Navigator.of(context)
                    .pushReplacementNamed(loginscreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.bottomAppBarTheme.color,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/icon_list.png')),
                label: AppLocalizations.of(context)!.task_list),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/icon_settings.png')),
                label: AppLocalizations.of(context)!.settings),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add, size: 35),
      ),
      body: selectedIndex == 0 ? Tasklist() : settingsTab(),
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: appcolors.primaryColor,
              width: 2,
            )),
        context: context,
        builder: (context) => AddBottomSheet());
  }
}
