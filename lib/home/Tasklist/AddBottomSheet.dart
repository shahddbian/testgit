import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/firsbaseutils.dart';
import '../../model/task.dart';
import '../../provider/listprovider.dart';
import '../../provider/userprovider.dart';

class AddBottomSheet extends StatefulWidget {
  Task? task;

  AddBottomSheet({this.task});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  String title = '';
  String desc = '';
  var formKey = GlobalKey<FormState>();
  DateTime selecdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      title = widget.task!.title;
      desc = widget.task!.description;
      selecdate = widget.task!.dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.task != null
                  ? AppLocalizations.of(context)!.edit_task
                  : AppLocalizations.of(context)!.add_new_task,
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
                      initialValue: title,
                      style: TextStyle(color: appcolors.darkbackColor),
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
                      initialValue: desc,
                      style: TextStyle(color: appcolors.darkbackColor),
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
                      addOrUpdateTask(context);
                    },
                    child: Text(
                      widget.task != null
                          ? AppLocalizations.of(context)!.edit
                          : AppLocalizations.of(context)!.add,
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

  void addOrUpdateTask(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      var userProvider = Provider.of<Userprovider>(context, listen: false);
      var listProv = Provider.of<listprovider>(context, listen: false);

      Task task = Task(
        id: widget.task?.id ?? '',
        title: title,
        dateTime: selecdate,
        description: desc,
        isDone: widget.task?.isDone ?? false,
      );

      if (widget.task == null) {
        firebaseUtils
            .addTasktoFireStore(task, userProvider.currentUser!.id)
            .then((value) {
          print('Task Added Successfully');
          listProv.getAllTasksfromFire(userProvider.currentUser!.id);
          Navigator.pop(context);
        }).catchError((error) {
          print('Error adding task: $error');
        });
      } else {
        firebaseUtils
            .editTaskFromFireStore(task, userProvider.currentUser!.id)
            .then((value) {
          print('Task Updated Successfully');
          listProv.getAllTasksfromFire(userProvider.currentUser!.id);
          Navigator.pop(context);
        }).catchError((error) {
          print('Error updating task: $error');
        });
      }
    }
  }

  void showCalender() async {
    var theme = Theme.of(context);
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selecdate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            primaryColor: appcolors.primaryColor,
            hintColor: appcolors.primaryColor,
            textTheme: TextTheme(
              headline4: TextStyle(
                  color: theme.brightness == Brightness.dark
                      ? appcolors.whiteColor
                      : appcolors.blackColor),
            ),
          ),
          child: child!,
        );
      },
    );
    if (chosenDate != null) {
      setState(() {
        selecdate = chosenDate;
      });
    }
  }
}

