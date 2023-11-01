import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/search_bloc/search_bloc.dart';

class AddCityCard extends StatefulWidget {
  final int index;

  const AddCityCard({Key? key, required this.index}) : super(key: key);

  @override
  State<AddCityCard> createState() => _AddCityCardState();
}

class _AddCityCardState extends State<AddCityCard> {
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final searchBloc = context.read<SearchBloc>();
    final successState = searchBloc.state as SearchSuccesfullState;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 2,
        top: 2,
      ),
      child: Card(
        color: Colors.black87,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            bottom: 8,
            top: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    successState.searchdata[index].name,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        successState.searchdata[index].admin1.toString(),
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white30,
                        ),
                      ),
                      Text(
                        ',',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white30,
                        ),
                      ),
                      Text(
                        successState.searchdata[index].country.toString(),
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () {
                    final cityToAdd = successState.searchdata[index];
                    searchBloc.add(AddCityEvent(city: cityToAdd));
                  },
                  icon: Icon(Icons.add, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
