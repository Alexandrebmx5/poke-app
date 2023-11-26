import 'dart:convert';

class Stats {

  String? name;
  String? url;
  num? baseStat;
  num? effort;

  Stats({this.name, this.url, this.baseStat, this.effort});

  factory Stats.fromJson(String str) =>
      Stats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
    name: json["stat"]["name"] == null ? null : json["stat"]["name"],
    url: json["stat"]["url"] == null ? null : json["stat"]["url"],
    baseStat: json["base_stat"] == null ? null : json["base_stat"],
    effort: json["effort"] == null ? null : json["effort"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "base_stat": baseStat == null ? null : baseStat,
    "effort": effort == null ? null : effort,
  };

  @override
  String toString() {
    return 'Stats{name: $name, url: $url, baseStat: $baseStat, effort: $effort}';
  }
}