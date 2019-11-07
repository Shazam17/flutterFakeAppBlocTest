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
  Schedule schedule;
  var loaded = true;

  ScheduleState(){
    fetchSchedule();
  }

  void fetchSchedule() async{
    var fetchedFile = await DefaultCacheManager()
        .getSingleFile(
        "https://timetable.tusur.ru/faculties/fsu/groups/428-2.ics");
    fetchedFile.readAsString().then((String content)
    {
      schedule = fileToSchedule(content);
      setState(() {
        loaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          title: new Text("realy cool app"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.refresh), onPressed: (){
              print("Reloading");
              setState(() {
                loaded = true;
              });
              fetchSchedule();
            })
          ],
        ),
        body: Center(
              child: loaded ? CircularProgressIndicator() : PageView.builder(
                  itemBuilder: (context,position){
                    return listView(position);
                  },
                  itemCount: schedule!= null ?  schedule.lessons.length : 0 ,)
            )
    );
  }
  listView(int i){
    return ListView.builder(
        itemCount: schedule != null ? schedule.lessons[i].length : 0 ,
        itemBuilder: (BuildContext context,int index){
          return Container(
              height: 50,
              child: Text("${ schedule.lessons[i][index].name}")
          );
        });
  }
}

