import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/bloc/weather_blocs/weather_bloc.dart';
import 'package:weather_app/data/HourForecastModel.dart';
import 'package:weather_app/data/WeatherDataModel.dart';

class HourForecast extends StatelessWidget {
  final WeatherDataModel hourForecast;

  const HourForecast({Key? key, required this.hourForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int getCurrentTimeInHours() {
  
  DateTime now = DateTime.now();
  
 
  int currentHour = now.hour;

  return currentHour;
}

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<double>  dashArray =[0.5,1];
    // Access hourly forecast data from the WeatherDataState
    final hourlyForecasts = hourForecast.generateHourlyForecast();

    // Create a list of data points for time, temperature, and wind speed
    final List<ChartSampleData> data = [];

    for (int i = 0; i < hourlyForecasts.length; i++) {
      final HourlyForecastModel forecast = hourlyForecasts[i];
      data.add(ChartSampleData(
        x: i,
        temperature: forecast.temperature,
        windSpeed: forecast.windSpeed,
      ));
    }

    return Container(
      height: screenHeight * 0.4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
                  'Today Hourly Forecast',
                  style:
                      GoogleFonts.montserrat(fontSize: 18, color: Colors.white70),
                ),
          ),

          SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 0,
                right: 20,
                top: 0,
              ),
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: screenHeight * 0.25,
                width: screenWidth,
                child: SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(enable: true ,textStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w300) ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    
                  ),

                  borderColor: Colors.transparent,
                  plotAreaBackgroundColor: Colors.transparent,
                  plotAreaBorderColor: Colors.transparent,
                  primaryXAxis: NumericAxis(
                    borderWidth: 0,
                    placeLabelsNearAxisLine: true,
                    isVisible: true,
                    axisLine: AxisLine(dashArray: dashArray, color: Colors.white, width: 0.5),
                    labelStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w300,color: Colors.white70),
                    decimalPlaces: 0,
                    
                    minimum: getCurrentTimeInHours().toDouble(),
                   
                    visibleMinimum: 1,
                    visibleMaximum: 6,
                    maximum: 24,
                    
                    zoomFactor: 1,
                    interval: 1,
                    labelFormat: '{value}:00',
                    title: AxisTitle(text: '', textStyle: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w300),),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    title: AxisTitle(text: 'Value', textStyle: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w300),),
                    majorGridLines: MajorGridLines(width: 1),
                  ),
                  series: <ChartSeries>[
                    LineSeries<ChartSampleData, int>(
                      //animationDuration: 1,

                      color: Colors.orange,
                      dataSource: data,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.temperature,
                      name: 'Temperature',
                      dataLabelMapper: (ChartSampleData data, _) =>
      data == null ? '' : '${data.temperature.toStringAsFixed(2)} °C',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                        labelPosition: ChartDataLabelPosition.outside,
                        //labelAlignment: ChartAlignment.center,
                         textStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w300),
                        
                      ),
                      markerSettings: MarkerSettings(
                        isVisible: false,
                        
                      ),
                    ),
                    LineSeries<ChartSampleData, int>(
                      dataSource: data,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.windSpeed,
                      name: 'Wind Speed',
                       dataLabelMapper: (ChartSampleData data, _) =>
      data == null ? '' : '${data.windSpeed.toStringAsFixed(2)} km/h',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                        labelPosition: ChartDataLabelPosition.outside,
                      //  labelAlignment: ChartAlignment.center,
                        textStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                      markerSettings: MarkerSettings(
                        isVisible: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
        ],
      ),);
    
  }
}

class ChartSampleData {
  final int x;
  final double temperature;
  final double windSpeed;

  ChartSampleData({
    required this.x,
    required this.temperature,
    required this.windSpeed,
  });
}
