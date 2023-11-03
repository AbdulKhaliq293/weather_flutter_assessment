import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/UI/search_screen.dart';
import 'package:weather_app/addedCitiesMAnager.dart';
import 'package:weather_app/bloc/search_bloc/search_bloc.dart';
import 'package:weather_app/data/SearchDataModel.dart';

class CityListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Cities'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     // Navigate to the search screen when the search button is tapped
          //     Navigator.pop(context, '/home');
              
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to the search screen when the search button is tapped
              Navigator.pushNamed(context, '/search');
              
            },
          ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
         final totalcities = AddedCitiesManager.instance.addedCities;

          if (state is CityAddedState) {
            final addedCities = context.read<SearchBloc>().addedCities;
            print("City Displayed");
            

            return ListView.builder(
              itemCount: addedCities.length,
              itemBuilder: (context, index) {
                final city = addedCities[index];
                return CityCard(city: city);
              },
            );
          } else if (state is CityRemovedState) {
            final removedCities = context.read<SearchBloc>().addedCities;
            print("City Displayed");

            return ListView.builder(
              itemCount: removedCities.length,
              itemBuilder: (context, index) {
                final city = removedCities[index];
                return CityCard(city: city);
              },
            );

          }
          else {
  return ListView.builder(
    itemCount: totalcities.length,
    itemBuilder: (context, index) {
      final city = totalcities[index];
      return CityCard(city: city);
    },
  );
}
         
        }
         

      ),
    );
  }
}

class CityCard extends StatelessWidget {
  final SearchDataModel city;

  CityCard({required this.city});

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      surfaceTintColor: Colors.black38,
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(city.name),
        subtitle: Text('${city.admin1}, ${city.country}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
          
            context.read<SearchBloc>().add(RemoveCityEvent(city: city));
          },
        ),
      ),
    );
  }
}
