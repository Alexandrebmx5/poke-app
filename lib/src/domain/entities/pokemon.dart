import 'dart:convert';

import 'package:poke_app/src/domain/entities/abilities.dart';
import 'package:poke_app/src/domain/entities/forms.dart';
import 'package:poke_app/src/domain/entities/stats.dart';
import 'package:poke_app/src/domain/entities/types.dart';

class Pokemon {

  num? id;
  String? name;
  num? height;
  num? weight;
  List<Abilities>? abilities;
  List<Forms>? forms;
  List<Stats>? stats;
  List<Types>? types;
  String? url;

  Pokemon({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.abilities,
    this.forms,
    this.stats,
    this.types,
    this.url
  });

  factory Pokemon.fromJson(String str) =>
      Pokemon.fromMap(json.decode(str));

  factory Pokemon.fromJsonTwo(String str) =>
      Pokemon.fromMapTwo(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    height: json["height"] == null ? null : json["height"],
    weight: json["weight"] == null ? null : json["weight"],
    abilities: json["abilities"] == null ? null : (json["abilities"] as List<dynamic>).map((e) =>
        Abilities.fromMap(e as Map<String, dynamic>)).toList(),
    forms: json["forms"] == null ? null : (json["forms"] as List<dynamic>).map((e) =>
        Forms.fromMap(e as Map<String, dynamic>)).toList(),
    stats: json["stats"] == null ? null : (json["stats"] as List<dynamic>).map((e) =>
        Stats.fromMap(e as Map<String, dynamic>)).toList(),
    types: json["types"] == null ? null : (json["types"] as List<dynamic>).map((e) =>
        Types.fromMap(e as Map<String, dynamic>)).toList(),
  );

  factory Pokemon.fromMapTwo(Map<String, dynamic> json) => Pokemon(
    name: json["pokemon"]['name'] == null ? null : json["pokemon"]["name"],
    url: json["pokemon"]["url"] == null ? null : json["pokemon"]["url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "abilities": abilities == null ? null : abilities!.map((e) => e.toMap()).toList(),
    "forms": forms == null ? null : forms!.map((e) => e.toMap()).toList(),
    "stats": stats == null ? null : stats!.map((e) => e.toMap()).toList(),
    "types": types == null ? null : types!.map((e) => e.toMap()).toList(),
  };

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name, height: $height, weight: $weight, abilities: $abilities, forms: $forms, stats: $stats, types: $types}';
  }
}