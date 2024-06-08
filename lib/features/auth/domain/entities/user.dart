
class User {
  int? id;
  bool? isMale;
  String? birthDate;
  int? weight;
  int? height;
  double? fitPercentage;
  int? coins;
  String? name;
  String? email;
  String? location;
  double? totalKm;
  String? profilePicture;

  User(
      {this.id,
      this.isMale,
      this.birthDate,
      this.weight,
      this.height,
      this.fitPercentage,
      this.coins,
      this.name,
      this.email,
      this.location,
      this.totalKm,
        this.profilePicture
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMale = json['isMale']==1;
    birthDate = json['birthDate'];
    weight = json['weight_kg'];
    height = json['height_cm'];
    fitPercentage = double.tryParse(json["fitPercentage"]??'0');
    totalKm = json['totalKm'];
    coins = json['coins'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isMale': isMale,
      'birthDate': birthDate,
      'weight_kg': weight,
      'height_cm': height,
      'fitPercentage': fitPercentage,
      'coins': coins,
      'name': name,
      'email': email,
      'location': location,
      'totalKm': totalKm,
      'profile_picture': profilePicture,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, isMale: $isMale, birthDate: $birthDate, weight: $weight, height: $height, fitPercentage: $fitPercentage, coins: $coins, name: $name, email: $email, location: $location, totalKm: $totalKm, profilePicture: $profilePicture}';
  }
}
