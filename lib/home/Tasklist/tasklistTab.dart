import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/appcolors.dart';
import 'package:todoapp/home/Tasklist/tasklistitem.dart';
import 'package:todoapp/provider/listprovider.dart';
import 'package:todoapp/provider/userprovider.dart';
import '../../model/task.dart';

class Tasklist extends StatefulWidget {
  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<listprovider>(context);
    var userProvider = Provider.of<Userprovider>(context);
    if (listProvider.tasklist.isEmpty) {
      listProvider.getAllTasksfromFire(userProvider.currentUser!.id);
    }

    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              listProvider.changedate(
                  selectedDate, userProvider.currentUser!.id);
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDayAsStrMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayNumDayStr,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff76ffda),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: listProvider.tasklist.isEmpty
                ? Center(child: Text('No Tasks Added'))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return tasklistitem(task: listProvider.tasklist[index]);
                    },
                    itemCount: listProvider.tasklist.length,
                  ),
          ),
        ],
      ),
    );
  }
}
