import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/UI/city_list_screen.dart';
import 'package:weather_app/UI/city_slider.dart';
import 'package:weather_app/UI/home_page.dart';
import 'package:weather_app/UI/search_screen.dart';
import 'package:weather_app/addedCitiesMAnager.dart';
import 'package:weather_app/bloc/search_bloc/search_bloc.dart';
import 'package:weather_app/bloc/weather_blocs/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  // Load addedCities from shared preferences
  await AddedCitiesManager.instance.loadAddedCities();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      
    return MultiBlocProvider(
      
      providers: [
            BlocProvider(create: (context) => SearchBloc()),
    BlocProvider(create: (context) => WeatherBloc()),

          ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.blue, // Change primary color (e.g., sky blue)
            secondary:
                Colors.orange, // Change secondary color (e.g., sun-like color)
            background: Colors.white, // Change background color to white
            surface: Colors.white, // Change surface color to white
            onPrimary:
                Colors.white, // Change text color on the primary color to white
            onSecondary: Colors
                .black, // Change text color on the secondary color to black
            onBackground:
                Colors.black, // Change text color on the background to black
            onSurface:
                Colors.black, // Change text color on the surface to black
            onError: Colors.red,
            // Change error color (e.g., red for alerts)
          ),
          cardColor: Colors.black54,
          useMaterial3: true, // You can set this to true if using Material 3
        ),
        
        home:  HomePage(),
        initialRoute: '/home',
        routes: {
          '/home':(context) => HomePage(),
      '/search': (context) => SearchScreen(), 
      '/addCity': (context) => CityListScreen(), // Add SearchScreen route
    },
      ),
    );
  }
}
