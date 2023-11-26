import 'dart:convert';

class Forms {

  String? name;
  String? url;

  Forms({this.name, this.url});

  factory Forms.fromJson(String str) =>
      Forms.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Forms.fromMap(Map<String, dynamic> json) => Forms(
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "url": url == null ? null : url,
  };

  @override
  String toString() {
    return 'Forms{name: $name, url: $url}';
  }
}