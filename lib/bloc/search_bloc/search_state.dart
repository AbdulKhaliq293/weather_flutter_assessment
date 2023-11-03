part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

abstract class SearchActionState extends SearchState {}
final class SearchDefaultState extends SearchState {}
final class SearchInitial extends SearchState {}
final class SearchLoadingState extends SearchState {}

class SearchSuccesfullState extends SearchState {
  late final List<SearchDataModel> searchdata;

  SearchSuccesfullState({required this.searchdata});
}

class CityAddedState extends SearchState {
  final List<SearchDataModel> city;

  CityAddedState({required this.city});
}

class CityRemovedState extends SearchState {
  final List<SearchDataModel> city;

  CityRemovedState({required this.city});
}




class ShowCityAddedSnackbar extends SearchState {}
