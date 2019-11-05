import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:async';
import 'dart:io';
abstract class WeatherEvent {}

class Generate extends WeatherEvent {
  final String name;

  Generate(this.name);
}


class WeatherState {
  final String cityName;
  final int degrees;

  WeatherState(this.cityName, this.degrees);
}


class BlocWeather extends Bloc<WeatherEvent, WeatherState> {

  @override
  WeatherState get initialState => WeatherState('', 0);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is Generate) {
      yield WeatherState(event.name, -123123);
    }
  }

}