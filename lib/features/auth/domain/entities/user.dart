
class User {
  int? id;
  bool? isMale;
  String? dateOfBirth;
  int? weight;
  int? height;
  double? fitPercentage;
  int? coins;
  String? name;
  String? email;
  String? location;
  double? totalKm;

  User(
      {this.id,
      this.isMale,
      this.dateOfBirth,
      this.weight,
      this.height,
      this.fitPercentage,
      this.coins,
      this.name,
      this.email,
      this.location,
      this.totalKm});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMale = json['isMale'];
    dateOfBirth = json['dateOfBirth'];
    weight = json['weight'];
    height = json['height'];
    fitPercentage = json['fitPercentage'];
    totalKm = json['totalKm'];
    coins = json['coins'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isMale': isMale,
      'dateOfBirth': dateOfBirth,
      'weight': weight,
      'height': height,
      'fitPercentage': fitPercentage,
      'coins': coins,
      'name': name,
      'email': email,
      'location': location,
      'totalKm': totalKm,
    };
  }

}
