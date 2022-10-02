class UserModel {
  String? email;
  String? name;

  UserModel({
    this.email,
    this.name,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        "name": name,
      };
}
