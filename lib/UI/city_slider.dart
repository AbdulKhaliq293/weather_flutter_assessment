import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/addedCitiesMAnager.dart';
import 'package:weather_app/bloc/search_bloc/search_bloc.dart';
import 'package:weather_app/bloc/weather_blocs/weather_bloc.dart';
import 'package:weather_app/data/SearchDataModel.dart';
import 'package:weather_app/data/WeatherDataModel.dart';
import 'package:weather_app/widgets/day_forecast.dart';
import 'package:weather_app/widgets/hour_forecast.dart';
import 'package:weather_app/widgets/info_card.dart';

import '../widgets/dot_widget.dart';

class CityScroll extends StatefulWidget {
  final int currentPageIndex;

  final SearchDataModel city;
  //final WeatherDataState weatherData;

  const CityScroll({
    Key? key,
    required this.city,
    required this.currentPageIndex,
  }) : super(key: key);

  @override
  State<CityScroll> createState() => _CityScrollState();
}

class _CityScrollState extends State<CityScroll> {
  @override
  void initState() {
    super.initState();

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    weatherBloc.add(FetchWeatherEvent(
        latitude: widget.city.latitude, longitude: widget.city.longitude));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final totalcities = AddedCitiesManager.instance.addedCities;

    final iconSize = screenWidth * 0.08;
    // final textSize = screenHeight * 0.03;
    final double paddingHeightSize = screenHeight * 0.04;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final List<SearchDataModel> cities = searchBloc.addedCities;
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoadingState) {
        return Scaffold(
            body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: RiveAnimation.asset(
                'assets/Dynamic_sunny.riv',
                fit: BoxFit.fill,
              ),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ));
      } else if (state is WeatherDataState && state != null) {
        final cityName = widget.city.name;
        final currentData = state.data.current;
        final hourlyData = state.data.hourly;
        final dailyData = state.data.daily;
        final weatherCondition = state.data.condition;
        List<dynamic> dailyMaxTemperatures = dailyData['temperature_2m_max'];
        num maxTemperature = dailyMaxTemperatures
            .map((value) => (value as num).toDouble()) 
            .reduce((value, element) => value > element ? value : element);
        List<dynamic> dailyMinTemperatures = dailyData['temperature_2m_min'];
        num minTemperature = dailyMinTemperatures
            .map((value) => (value as num).toDouble()) 
            .reduce((value, element) => value < element ? value : element);
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: const RiveAnimation.asset(
                  'assets/Dynamic_sunny.riv',
                  fit: BoxFit.fill,
                  animations: ['cloudsDefault'],

                
                ),
              ), // Make sure the animation file exists
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: paddingHeightSize, left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: IconButton(
                              iconSize: iconSize,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, '/addCity');
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                          Text(
                            cityName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                              onPressed: () {
                                final weatherBloc =
                                    BlocProvider.of<WeatherBloc>(context);

                                weatherBloc.add(FetchWeatherEvent(
                                    latitude: widget.city.latitude,
                                    longitude: widget.city.longitude));
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        cities.length,
                        (index) => Dot(
                          isActive: index == widget.currentPageIndex,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.09,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (currentData['temperature_2m'].toInt()).toString(),
                          style: GoogleFonts.montserrat(
                              fontSize: 96,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 60, left: 5),
                          child: Text(
                            "°C",
                            style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weatherCondition.toString().split('.').last,
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${maxTemperature.toInt().toString()}°C",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " /",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "${minTemperature.toInt().toString()}°C",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.20,
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: DayForecast(
                          forecast: state.data,
                        )),
                    SizedBox(
                      height: screenHeight * 0.001,
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: HourForecast(
                          hourForecast: state.data,
                        )),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: InfoWidget(currentData: state.data)),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (state is WeatherErrorState) {
        return Scaffold(
          body: Center(child: Text(state.error)),
        );
      } else {
        return Scaffold(body: Center(child: Text('Nothing')));
      }
    });
  }
}
