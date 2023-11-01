part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class IntialSearchEvent extends SearchEvent {
  final String userQuery;

  IntialSearchEvent({required this.userQuery});
 
  
}
class AddCityEvent extends SearchEvent {
  final SearchDataModel city;

  AddCityEvent({required this.city});
}
class RemoveCityEvent extends SearchEvent { // Add this event
  final SearchDataModel city;

  RemoveCityEvent({required this.city});
}
