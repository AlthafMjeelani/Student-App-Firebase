class DetailsModel {
  final String? password;
  final String? email;
  final String? name;
  final String? age;
  final String? mobileNumber;
  final String? id;

  DetailsModel({
    this.email,
    this.password,
    required this.name,
    required this.id,
    required this.age,
    required this.mobileNumber,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      age: json['age'],
      mobileNumber: json['mobileNumber'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        "name": name,
        'password': password,
        'age': age,
        "mobileNumber": mobileNumber,
        "id": id,
      };
}
