import 'dart:convert';

class Abilities {

  String? name;
  String? url;
  bool? isHidden;
  num? slot;

  Abilities({this.name, this.url, this.isHidden, this.slot});

  factory Abilities.fromJson(String str) =>
      Abilities.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Abilities.fromMap(Map<String, dynamic> json) => Abilities(
    name: json["ability"]["name"] == null ? null : json["ability"]["name"],
    url: json["ability"]["url"] == null ? null : json["ability"]["url"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    slot: json["slot"] == null ? null : json["slot"],
  );

  factory Abilities.fromMapFavorites(Map<String, dynamic> json) => Abilities(
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    slot: json["slot"] == null ? null : json["slot"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "is_hidden": isHidden == null ? null : isHidden,
    "slot": slot == null ? null : slot,
  };

  @override
  String toString() {
    return 'Abilities{name: $name, url: $url, isHidden: $isHidden, slot: $slot}';
  }
}