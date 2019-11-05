import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(App());


class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: BlocProvider<BlocWeather>(
        builder: (context) => BlocWeather(),
            child: RandomWeather(),
      ),
    );
  }

}

abstract class WeatherEvent{


}

class Generate extends WeatherEvent{
  final String name;
  Generate({this.name});
}
class WeatherState {
  final String cityName;
  final int degrees;
  WeatherState({this.cityName,this.degrees});
}
class BlocWeather extends Bloc<WeatherEvent,WeatherState>{

  @override
  WeatherState get initialState => WeatherState('',0);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
      if(event is Generate){
        yield WeatherState(event.name,-123123);
      }
  }

}

class RandomWeather extends StatefulWidget {
  @override
  RandomWeatherState createState() {
    return RandomWeatherState();
  }
}

class RandomWeatherState extends State<RandomWeather> {
  var text = '';

  @override
  Widget build(BuildContext context) {
    final BlocWeather bloc = BlocProvider.of<BlocWeather>(context);
    return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                hintText: 'Enter cityName'),
            onChanged: (txt){
              text = txt;
            },
          ),
          FlatButton(
            child: Text("button"),
            onPressed: (){
              bloc.add(Generate(text));
            },
          ),
          BlocBuilder<BlocWeather,WeatherState>(
            builder: (context,weather){
              return Column(
                children: <Widget>[
                  Text("city is ${weather.cityName}"),
                  Text("The weather is ${weather.degrees}")
                ],
              );
            },
          )
        ],
      )
    );
  }
}
