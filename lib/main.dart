import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/home/auth/login/loginscreen.dart';
import 'package:todoapp/home/auth/register/registerscreen.dart';
import 'package:todoapp/home/homescreen.dart';
import 'package:todoapp/provider/appconfigprovider.dart';
import 'package:todoapp/provider/listprovider.dart';
import 'package:todoapp/provider/userprovider.dart';
import 'themedatamine.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBe3CegrZ0kzS6Cm4MKyghhKjf86Z38M78',
      appId: 'com.example.todoapp',
      messagingSenderId: '196395095519',
      projectId: 'todo-app1-cb381',
    ),
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => listprovider(),
      ),
      ChangeNotifierProvider(create: (context) => Userprovider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: loginscreen.routeName,
      routes: {
        homescreen.routeName: (context) => homescreen(),
        registerscreen.routeName: (context) => registerscreen(),
        loginscreen.routeName: (context) => loginscreen(),
      },
      theme: myThemedate.lightTheme,
      darkTheme: myThemedate.darkTheme,
      themeMode: provider.appMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.applanguage),
    );
  }
}
