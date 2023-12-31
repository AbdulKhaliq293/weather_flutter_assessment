import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
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
  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    PageController pageController = PageController();
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
//final addedCities = searchBloc.addedCities;
    final totalCities = AddedCitiesManager.instance.addedCities;

    // if (addedCities.length != null && addedCities.length > 0) {
    //   print("the number of cities saved${addedCities.length}");

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is CityAddedState) {
        final addedCities = context.read<SearchBloc>().addedCities;
        return PageView.builder(
          controller: pageController,
          itemCount: addedCities.length,
          itemBuilder: (context, index) {
            return CityScroll(
              city: state.city[index],
              currentPageIndex: index,
            );
          },
        );
      } else if (state is CityRemovedState) {
        final addedCities = context.read<SearchBloc>().addedCities;
        return PageView.builder(
          controller: pageController,
          itemCount: addedCities.length,
          itemBuilder: (context, index) {
            return CityScroll(
              city: state.city[index],
              currentPageIndex: index,
            );
          },
        );
      } else if(totalCities.length>=0 && totalCities.length!=0){
        return PageView.builder(
          controller: pageController,
          itemCount: totalCities.length,
          itemBuilder: (context, index) {
            return CityScroll(
              city: totalCities[index],
              currentPageIndex: index,
            );
          },
        );
      }else {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: RiveAnimation.asset(
                  'assets/sunny_day.riv',
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Container(
                  child: IconButton(
                    iconSize: screenSize.width * 0.3,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/addCity');
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  //}
//else{ print("Navigating to CityListScreen");
}
