class Group{
  Group({required this.name});
  final String name;

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json["name"],
    );
  }
}