class PathDescription{

  // --- Variables ---
  late int id;
  late String name;
  late String date;

  PathDescription(this.id, this.name, this.date);
  factory PathDescription.fromJson(dynamic json) {
    return PathDescription(json['id'] as int, json['name'] as String, json['date'] as String);
  }

}