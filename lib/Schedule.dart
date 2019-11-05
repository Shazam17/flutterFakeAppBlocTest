import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Lesson {
  //String date;
  String name;
}

class Schedule {
  List lessons = new List<List<Lesson>>();

  void addLesson(int day, Lesson lesson) {
    lessons[day].add(lesson);
  }

}

Schedule fileToSchedule(String file){
  var schedule = Schedule();

  var lessons = file.split("BEGIN:VEVENT");
  lessons.removeAt(0);
  lessons.forEach((String lesson){
    var props = lesson.split("\n");
    debugPrint(props[4]);
  });

return schedule;
}