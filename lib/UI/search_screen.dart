import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/search_bloc/search_bloc.dart';
import 'package:weather_app/widgets/add_city.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String userInput = '';
  bool isSuccess = false; // Added flag to track success state

  void onSearchButtonPressed() {
    // Access the SearchBloc instance from the context
    final searchBloc = context.read<SearchBloc>(); // Use context.read to get the bloc

    // Dispatch the IntialSearchEvent
    final userQuery = searchController.text;
    searchBloc.add(IntialSearchEvent(userQuery: userQuery));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccesfullState) {
            setState(() {
              isSuccess = true;
            });
          } else if (state is SearchLoadingState) {
            setState(() {
              isSuccess = false;
            });
          }
        },
        child:
            isSuccess ? _buildSuccessContent() : _buildInitialSearchContent(),
      ),
    );
  }

  Widget _buildSuccessContent() {
    final succesState = context.read<SearchBloc>().state as SearchSuccesfullState;
    return Column(
      children: [
        _SearchBar(),
        Expanded(
          child: ListView.builder(
            itemCount: succesState.searchdata.length,
            itemBuilder: (BuildContext context, int index) {
              return AddCityCard(index: index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInitialSearchContent() {
    return _SearchBar();
  }

  Widget _SearchBar() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your City Name',
                ),
              ),
            ),
            SizedBox(
              width: 18,
            ),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6),
                color: Colors.black87,
              ),
              child: IconButton(
                color: Colors.white,
                focusColor: Colors.black87,
                onPressed: onSearchButtonPressed,
                icon: Icon(Icons.search_sharp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
