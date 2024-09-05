import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/dialogUtils.dart';
import 'package:todoapp/firsbaseutils.dart';
import 'package:todoapp/home/auth/costumTextform.dart';
import 'package:todoapp/home/auth/register/registerscreen.dart';
import 'package:todoapp/home/homescreen.dart';

import '../../../provider/userprovider.dart';

class loginscreen extends StatelessWidget {
  static const String routeName = 'login Screen';
  TextEditingController emialController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    customTextform(
                      label: 'Email',
                      controller: emialController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter valid Email';
                        }
                        return null;
                      },
                      KeyboardType: TextInputType.emailAddress,
                    ),
                    customTextform(
                      label: 'Password',
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Password';
                        }
                        if (text.length < 6) {
                          return 'Password must be at least 6 chars';
                        }

                        return null;
                      },
                      KeyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                          onPressed: () {
                            login(context);
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(registerscreen.routeName);
                        },
                        child: Text(
                          'Or create account',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: appcolors.primaryColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        dialogutils.showLoading(
            context: context,
            LoadingLabel: 'Waiting',
            barrierDismissible: false);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emialController.text, password: passwordController.text);
        firebaseUtils.readUserfromfire(credential.user?.uid ?? '');
        var user =
            await firebaseUtils.readUserfromfire(credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<Userprovider>(context, listen: false);
        userProvider.updateUser(user);
        dialogutils.hideLoading(context);
        dialogutils.showsms(
            context: context,
            content: 'login Successfully',
            title: 'Succes',
            postiveActionname: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(homescreen.routeName);
            });
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          dialogutils.hideLoading(context);
          dialogutils.showsms(
              context: context,
              content: 'No user found for that email.',
              title: 'Error',
              postiveActionname: 'Ok');
        } else if (e.code == 'wrong-password') {
          dialogutils.hideLoading(context);
          dialogutils.showsms(
              context: context,
              content: 'Wrong password',
              title: 'Error',
              postiveActionname: 'Ok');
        }
      } catch (e) {
        dialogutils.hideLoading(context);
        dialogutils.showsms(
            context: context,
            content: e.toString(),
            title: 'Error',
            postiveActionname: 'Ok');
      }
    }
  }
}
