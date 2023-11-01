

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/weather_blocs/weather_bloc.dart';
import 'package:weather_app/data/WeatherDataModel.dart';

class InfoWidget extends StatelessWidget {
  final WeatherDataModel currentData;
  const InfoWidget({super.key, required this.currentData});

  @override
  Widget build(BuildContext context) {
   // 'temperature_2m,relativehumidity_2m,apparent_temperature,is_day,rain,showers,snowfall,pressure_msl,surface_pressure,windspeed_10m',
    int humidity = currentData.current['relativehumidity_2m'];
    double real_feel = currentData.current['apparent_temperature'];
    double rainchance = currentData.current['rain']*100;
    double surface_pressure = currentData.current['surface_pressure'];
    double Pressure = currentData.current['pressure_msl'];

     final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(height: screenHeight * 0.35,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),),
        child: Column(
          children: [
            DynamicRow(keyData: "Humidty", keyValue: '${humidity.toStringAsFixed(1)} %'),
            DynamicRow(keyData: "Real Feel", keyValue:'${real_feel.toStringAsFixed(0)} °C' ),
            DynamicRow(keyData: "Rain Chances", keyValue: '${rainchance.toStringAsFixed(0)} %'),
            DynamicRow(keyData: "Surface Pressure", keyValue: '${surface_pressure.toStringAsFixed(0)} msl'),
            DynamicRow(keyData: "Overall Pressure", keyValue: '${Pressure.toStringAsFixed(1)} msl'),
           

          ],
        ) ,
        
        );
  }
}
class DynamicRow extends StatelessWidget {
  final String keyData;
 final String keyValue;
 

  DynamicRow(
      {required this.keyData, required this.keyValue, });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 12, left: 10, right: 10),
      child: Container(
        margin: EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Text(keyData,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white70,
                    )),
                    Text(keyValue.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white70,
                    )),
          ],
        ),
      ),
    );
  }
}
