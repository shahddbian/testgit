import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/firsbaseutils.dart';
import 'package:todoapp/provider/listprovider.dart';

import '../../model/task.dart';
import '../../provider/userprovider.dart';

class tasklistitem extends StatelessWidget {
  Task task;

  tasklistitem({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<listprovider>(context);
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
                var userProvider =
                    Provider.of<Userprovider>(context, listen: false);
                firebaseUtils
                    .deletetaskfromfire(task, userProvider.currentUser!.id)
                    .then((value) {
                  print('task deleted');
                  listProvider
                      .getAllTasksfromFire(userProvider.currentUser!.id);
                }).timeout(Duration(seconds: 1), onTimeout: () {
                  print('task deleted');
                  listProvider
                      .getAllTasksfromFire(userProvider.currentUser!.id);
                });
              },
              backgroundColor: appcolors.redColor,
              foregroundColor: appcolors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {},
              backgroundColor: appcolors.primaryColor,
              foregroundColor: appcolors.whiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: appcolors.whiteColor,
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.1,
                width: 4,
                color: appcolors.primaryColor,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(task.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: appcolors.primaryColor)),
                  Text(task.description,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appcolors.primaryColor),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check,
                        size: 35, color: appcolors.whiteColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
