import 'dart:convert';

import 'package:poke_app/src/domain/entities/pokemon.dart';

class Types {

  String? name;
  String? url;
  num? slot;
  List<Pokemon>? pokemon;

  Types({this.name, this.url, this.slot, this.pokemon});

  factory Types.fromJson(String str) =>
      Types.fromMap(json.decode(str));

  factory Types.fromJsonTwo(String str) =>
      Types.fromMapTwo(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Types.fromMap(Map<String, dynamic> json) => Types(
    name: json["type"]["name"] == null ? json["name"] == null ? null : json["name"] : json["type"]["name"],
    url: json["type"]["url"] == null ? json["url"] == null ? null : json["url"] : json["type"]["url"],
    slot: json["slot"] == null ? null : json["slot"],
  );

  factory Types.fromMapFavorites(Map<String, dynamic> json) => Types(
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    slot: json["slot"] == null ? null : json["slot"],
  );

  factory Types.fromMapTwo(Map<String, dynamic> json) => Types(
    name: json["name"] == null ?  null : json["name"],
    url: json["url"] == null ? null : json["url"],
    pokemon: json["pokemon"] == null ? null : (json["pokemon"] as List<dynamic>).map((e) =>
        Pokemon.fromMapTwo(e as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "slot": slot == null ? null : slot,
  };

  @override
  String toString() {
    return 'Types{name: $name, url: $url, slot: $slot}';
  }
}