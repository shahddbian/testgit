import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/firsbaseutils.dart';
import 'package:todoapp/home/Tasklist/AddBottomSheet.dart';
import 'package:todoapp/provider/listprovider.dart';
import '../../model/task.dart';
import '../../provider/userprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/dialogUtils.dart';
import 'package:todoapp/home/homescreen.dart';

class tasklistitem extends StatefulWidget {
  final Task task;
  tasklistitem({required this.task});

  @override
  State<tasklistitem> createState() => _tasklistitemState();
}

class _tasklistitemState extends State<tasklistitem> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<listprovider>(context);
    var userProvider = Provider.of<Userprovider>(context, listen: false);
    var theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                firebaseUtils
                    .deletetaskfromfire(
                        widget.task, userProvider.currentUser!.id)
                    .then((_) {
                  listProvider
                      .getAllTasksfromFire(userProvider.currentUser!.id);
                });
              },
              backgroundColor: appcolors.redColor,
              foregroundColor: theme.colorScheme.onError,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => AddBottomSheet(task: widget.task),
                );
              },
              backgroundColor: appcolors.primaryColor,
              foregroundColor: theme.colorScheme.onPrimary,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.1,
                width: 4,
                color: widget.task.isDone
                    ? appcolors.greenColor
                    : appcolors.primaryColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.task.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      widget.task.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.task.isDone
                      ? appcolors.greenColor
                      : appcolors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    widget.task.isDone = !widget.task.isDone;

                    if (widget.task.isDone) {
                      firebaseUtils
                          .editTaskFromFireStore(
                              widget.task, userProvider.currentUser!.id)
                          .then((_) {
                        listProvider
                            .getAllTasksfromFire(userProvider.currentUser!.id);
                        dialogutils.showsms(
                          context: context,
                          content: 'Task completed successfully!',
                          title: 'Success',
                          postiveActionname: 'OK',
                          posAction: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => homescreen(),
                              ),
                            );
                          },
                        );
                      });
                    }
                  });
                },
                child: widget.task.isDone
                    ? Text(
                        "Done",
                        style: TextStyle(
                            color: theme.colorScheme.onPrimary, fontSize: 18),
                      )
                    : Icon(
                        Icons.check,
                        color: theme.colorScheme.onPrimary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
