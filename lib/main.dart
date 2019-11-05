import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:async';
import 'dart:io';
import 'Schedule.dart';


void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: Scheduler(),
    );
  }

}


class Scheduler extends StatefulWidget {
  @override
  ScheduleState createState() {
    return ScheduleState();
  }
}

class ScheduleState extends State<Scheduler> {
  Schedule scheduler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("fetch"),
              onPressed: () async {
                var fetchedFile = await DefaultCacheManager()
                    .getSingleFile(
                    "https://timetable.tusur.ru/faculties/fsu/groups/428-2.ics");
                    fetchedFile.readAsString().then((String content)
                {
                    scheduler = fileToSchedule(content);
                });
              },
            )
          ],
        )
    );
  }
}

