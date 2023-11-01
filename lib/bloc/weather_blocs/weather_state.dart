part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherDataState extends WeatherState {
  final WeatherDataModel data;

  WeatherDataState({required this.data});

 


}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState({required this.error});
}
