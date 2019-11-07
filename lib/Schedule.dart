import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Lesson {
  List<String> data;
  String name;
  Lesson(this.name,this.data);
}

class Schedule {
  List<List<Lesson>> lessons;


  Schedule(){
    lessons = List<List<Lesson>>();
    for(int i = 0 ; i < 7 ;i++){
      lessons.add(List<Lesson>());
    }
  }

  List<Lesson> getLessonsOfDay(){
    List<Lesson> les = List<Lesson>();
    var day = DateTime.now().day.toString();
    if (day.length == 1){
      day = "0$day";
    }
    lessons.forEach((list){
      list.forEach((lesson){
        if(lesson.data[0] == DateTime.now().month.toString() &&
            lesson.data[1] == day){
              les.add(lesson);
        }

      });
    });
    les.sort((str1 ,str2) => str1.data[2].compareTo(str2.data[2]));
    return les;
  }
  void addLesson(int day, Lesson lesson) {
    lessons[day].add(lesson);
  }

}

Schedule fileToSchedule(String file){
  var schedule = Schedule();
  int count = 0;
  var lessons = file.split("BEGIN:VEVENT");
  lessons.removeAt(0);
  lessons.forEach((String lesson){
    var props = lesson.split("\n");
    
    var date = props[2].substring(46 ,60);

    var now = DateTime.now();
    var dataList = List<String>();
    dataList.add(date.substring(4,6));
    dataList.add(date.substring(6,8));

    dataList.add(date.substring(9,11));
    dataList.add(date.substring(11,13));


    schedule.addLesson(0, Lesson(props[4].split(":")[1],dataList));
      //schedule.lessons
      //schedule.lessons.sort((a ,b) => b.data[now.weekday][3].compareTo(a.data[now.weekday][3]));

    schedule.lessons.forEach((list) {
      //list.sort((a ,b) => b.data[now.weekday][2].compareTo(a.data[now.weekday][2]));
      //list.sort((a ,b) => b.data[now.weekday][3].compareTo(a.data[now.weekday][3]));
    });
  });

  return schedule;
}