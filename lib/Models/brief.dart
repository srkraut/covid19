import 'dart:convert';

Brief briefFromJson(String str) => Brief.fromJson(json.decode(str));

String briefToJson(Brief data) => json.encode(data.toJson());

class Brief {
  int confirmed;
  int deaths;
  int recovered;

  Brief({
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  factory Brief.fromJson(Map<String, dynamic> json) => Brief(
        confirmed: json["confirmed"],
        deaths: json["deaths"],
        recovered: json["recovered"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
        "deaths": deaths,
        "recovered": recovered,
      };
}
