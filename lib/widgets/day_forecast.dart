import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_blocs/weather_bloc.dart';
import 'package:weather_app/data/WeatherDataModel.dart';

class DayForecast extends StatelessWidget {
  final WeatherDataModel forecast;
  const DayForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final dailyForecasts = forecast.generateDailyForecast();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight * 0.35,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 14),
              child: Text(
                '7-day forecast',
                style:
                    GoogleFonts.montserrat(fontSize: 18, color: Colors.white70),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dailyForecasts.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final forecast = dailyForecasts[index];

                  return DynamicRow(
                    day: DateFormat('E')
                        .format(forecast.date), // Display weekday abbreviation
                    max_temp: forecast.maxTemp.toInt(),
                    min_temp: forecast.minTemp.toInt(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DynamicRow extends StatelessWidget {
  final String day;
  final int max_temp;
  final int min_temp;

  DynamicRow(
      {required this.day, required this.max_temp, required this.min_temp});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 12),
              Icon(Icons.sunny, color: Colors.orange),
              SizedBox(width: 6.0),
              Text(day,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${max_temp.toStringAsFixed(0)} C°',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white,
                  )),
              Text('/',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.white30,
                  )),
              Text('${min_temp.toStringAsFixed(0)} C°',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
