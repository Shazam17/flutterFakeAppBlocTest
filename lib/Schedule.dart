import 'dart:async';
import 'dart:io';

class Lesson {
  String date;
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

}