import 'dart:convert';

List<SearchDataModel> searchDataModelListFromJson(String str) =>
    List<SearchDataModel>.from(
        json.decode(str)["results"].map((x) => SearchDataModel.fromJson(x)));

String searchDataModelListToJson(List<SearchDataModel> data) =>
    json.encode({"results": List<dynamic>.from(data.map((x) => x.toJson()))});

class SearchDataModel {
  int id;
  String name;
  double latitude;
  double longitude;
  double elevation;
  String featureCode;
  String countryCode;
  int? admin1Id;
  String timezone;
  int? population;
  int? countryId;
  String country;
  String? admin1;

  SearchDataModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    this.admin1Id,
    required this.timezone,
    this.population,
    this.countryId,
    required this.country,
    this.admin1,
  });

  factory SearchDataModel.fromJson(Map<String, dynamic> json) => SearchDataModel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        elevation: json["elevation"].toDouble(),
        featureCode: json["feature_code"],
        countryCode: json["country_code"],
        admin1Id: json["admin1_id"],
        timezone: json["timezone"],
        population: json["population"],
        countryId: json["country_id"],
        country: json["country"],
        admin1: json["admin1"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "elevation": elevation,
        "feature_code": featureCode,
        "country_code": countryCode,
        "admin1_id": admin1Id,
        "timezone": timezone,
        "population": population,
        "country_id": countryId,
        "country": country,
        "admin1": admin1,
      };
}
