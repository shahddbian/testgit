import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dialogUtils.dart';
import 'package:todoapp/firsbaseutils.dart';
import 'package:todoapp/home/auth/costumTextform.dart';
import 'package:todoapp/home/homescreen.dart';
import 'package:todoapp/model/dataClass.dart';
import '../../../provider/userprovider.dart';

class registerscreen extends StatelessWidget {
  static const String routeName = 'register Screen';
  TextEditingController nameController = TextEditingController();
  TextEditingController emialController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
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
                    customTextform(
                      label: 'User Name',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter User Name';
                        }
                        return null;
                      },
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
                    customTextform(
                      label: 'Confirm Password',
                      controller: confirmpasswordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Confirm Password';
                        }
                        if (text.length < 6) {
                          return 'Password must be at least 6 chars';
                        }
                        if (text != passwordController.text) {
                          return 'Passwords not match';
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
                            register(context);
                          },
                          child: Text(
                            'Create Account',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void register(BuildContext context) async {
    //todoapp : show Loading

    if (formKey.currentState?.validate() == true) {
      dialogutils.showLoading(
          context: context,
          LoadingLabel: 'Loading..',
          barrierDismissible: false);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emialController.text, password: passwordController.text);
        Myuser myUser = Myuser(
            id: credential.user?.uid ?? '',
            email: emialController.text,
            name: nameController.text);

        await firebaseUtils.addUsertofire(myUser);
        var userProvider = Provider.of<Userprovider>(context, listen: false);
        userProvider.updateUser(myUser);
        dialogutils.hideLoading(context);
        dialogutils.showsms(
            context: context,
            content: 'register Successfully',
            title: 'Succes',
            postiveActionname: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(homescreen.routeName);
            });

        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak password') {
          dialogutils.hideLoading(context);
          dialogutils.showsms(
              context: context,
              content: 'The password provided is too weak',
              title: 'Error',
              postiveActionname: 'Ok');
        } else if (e.code == 'email-already used') {
          dialogutils.hideLoading(context);
          dialogutils.showsms(
              context: context,
              content: 'The account already exists for that email',
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