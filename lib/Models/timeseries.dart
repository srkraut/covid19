import 'dart:convert';

List<Timeseries> timeseriesFromJson(String str) =>
    List<Timeseries>.from(json.decode(str).map((x) => Timeseries.fromJson(x)));

String timeseriesToJson(List<Timeseries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Timeseries {
  String provincestate;
  String countryregion;
  DateTime lastupdate;
  Location location;
  Countrycode countrycode;
  Map<String, Timesery> timeseries;

  Timeseries({
    this.provincestate,
    this.countryregion,
    this.lastupdate,
    this.location,
    this.countrycode,
    this.timeseries,
  });

  factory Timeseries.fromJson(Map<String, dynamic> json) => Timeseries(
        provincestate: json["provincestate"],
        countryregion: json["countryregion"],
        lastupdate: DateTime.parse(json["lastupdate"]),
        location: Location.fromJson(json["location"]),
        countrycode: json["countrycode"] == null
            ? null
            : Countrycode.fromJson(json["countrycode"]),
        timeseries: Map.from(json["timeseries"])
            .map((k, v) => MapEntry<String, Timesery>(k, Timesery.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "provincestate": provincestate,
        "countryregion": countryregion,
        "lastupdate": lastupdate.toIso8601String(),
        "location": location.toJson(),
        "countrycode": countrycode == null ? null : countrycode.toJson(),
        "timeseries": Map.from(timeseries)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Countrycode {
  String iso2;
  String iso3;

  Countrycode({
    this.iso2,
    this.iso3,
  });

  factory Countrycode.fromJson(Map<String, dynamic> json) => Countrycode(
        iso2: json["iso2"],
        iso3: json["iso3"],
      );

  Map<String, dynamic> toJson() => {
        "iso2": iso2,
        "iso3": iso3,
      };
}

class Location {
  double lat;
  double lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Timesery {
  int confirmed;
  int deaths;
  int recovered;

  Timesery({
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  factory Timesery.fromJson(Map<String, dynamic> json) => Timesery(
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        deaths: json["deaths"] == null ? null : json["deaths"],
        recovered: json["recovered"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed == null ? null : confirmed,
        "deaths": deaths == null ? null : deaths,
        "recovered": recovered,
      };
}
