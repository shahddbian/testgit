import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/firsbaseutils.dart';
import 'package:todoapp/home/Tasklist/AddBottomSheet.dart';
import 'package:todoapp/provider/listprovider.dart';
import '../../model/task.dart';
import 'package:todoapp/provider/userprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/dialogUtils.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
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
                _deleteTask(userProvider.currentUser!.id);
              },
              backgroundColor: appcolors.redColor,
              foregroundColor: theme.colorScheme.onError,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                _showEditTaskBottomSheet();
              },
              backgroundColor: appcolors.primaryColor,
              foregroundColor: theme.colorScheme.onPrimary,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: _buildTaskItem(theme, userProvider.currentUser!.id),
      ),
    );
  }

  void _deleteTask(String userId) {
    firebaseUtils.deletetaskfromfire(widget.task, userId).then((_) {
      Provider.of<listprovider>(context, listen: false)
          .getAllTasksfromFire(userId);
    });
  }

  void _showEditTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddBottomSheet(task: widget.task),
    );
  }

  Widget _buildTaskItem(ThemeData theme, String userId) {
    return Container(
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
          _buildTaskActionButton(userId),
        ],
      ),
    );
  }

  Widget _buildTaskActionButton(String userId) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.task.isDone ? appcolors.greenColor : appcolors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onPressed: () {
        _toggleTaskCompletion(userId);
      },
      child: widget.task.isDone
          ? Text("Done", style: TextStyle(color: Colors.white, fontSize: 18))
          : Icon(Icons.check, color: Colors.white),
    );
  }

  void _toggleTaskCompletion(String userId) {
    setState(() {
      widget.task.isDone = !widget.task.isDone;
    });

    firebaseUtils.editTaskFromFireStore(widget.task, userId).then((_) {
      Provider.of<listprovider>(context, listen: false)
          .getAllTasksfromFire(userId);
      dialogutils.showsms(
        context: context,
        content: widget.task.isDone
            ? 'Task completed successfully!'
            : 'Task marked as incomplete!',
        title: 'Success',
        postiveActionname: 'OK',
        posAction: () {
          Navigator.of(context).pop();
        },
      );
    });
  }
}
