import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/UI/city_list_screen.dart';
import 'package:weather_app/UI/city_slider.dart';
import 'package:weather_app/addedCitiesMAnager.dart';
import 'package:weather_app/bloc/search_bloc/search_bloc.dart';
import 'package:weather_app/bloc/weather_blocs/weather_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
     
    
 
  }
  

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    final searchBloc = BlocProvider.of<SearchBloc>(context);
final addedCities = searchBloc.addedCities;
final totalCities = AddedCitiesManager.instance.addedCities;

   
    if (totalCities.length != null && totalCities.length > 0) {
      print("the number of cities saved${addedCities.length}");
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return PageView.builder(
  controller: pageController,
  itemCount: addedCities.length,
  itemBuilder: (context, index) {
    return CityScroll(city: addedCities[index], currentPageIndex: index,);
  },
);;
      },
    );}
else{ print("Navigating to CityListScreen");

  return CityListScreen();}
  
}
}