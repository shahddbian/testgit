import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/firsbaseutils.dart';

import '../../model/task.dart';
import '../../provider/listprovider.dart';
import '../../provider/userprovider.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  String title = '';
  String desc = '';
  var formKey = GlobalKey<FormState>();
  var selecdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_task,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: appcolors.blackColor,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Task Title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Task Title',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        desc = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Task Description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Task Description',
                      ),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.select_date,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: appcolors.blackColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Text(
                        '${selecdate.day}/${selecdate.month}/${selecdate.year}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: appcolors.blackColor,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addtask(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: appcolors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addtask(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      var userProvider = Provider.of<Userprovider>(context, listen: false);
      var listProv = Provider.of<listprovider>(context, listen: false);

      Task task = Task(
        title: title,
        dateTime: selecdate,
        description: desc,
      );

      firebaseUtils
          .addTasktoFireStore(task, userProvider.currentUser!.id)
          .then((value) {
        print('Task Added Successfully');
        listProv.getAllTasksfromFire(userProvider.currentUser!.id);
        Navigator.pop(context); // قم بغلق الـ BottomSheet بعد إضافة المهمة
      }).timeout(Duration(seconds: 1), onTimeout: () {
        print('Task Added Successfully (Timeout)');
        listProv.getAllTasksfromFire(userProvider.currentUser!.id);
        Navigator.pop(context); // قم بغلق الـ BottomSheet بعد إضافة المهمة
      });
    }
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      selecdate = chosenDate;
      setState(() {});
    }
  }
}
