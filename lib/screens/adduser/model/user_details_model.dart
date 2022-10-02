class DetailsModel {
  String? email;
  String? name;
  String? age;
  String? domain;
  String? mobileNumber;

  String? uId;

  DetailsModel({
    this.email,
    this.name,
    this.uId,
    this.age,
    this.domain,
    this.mobileNumber,
  });

  factory DetailsModel.fromMap(map) {
    return DetailsModel(
      email: map['email'],
      name: map['name'],
      age: map['age'],
      uId: map['uId'],
      domain: map['domain'],
      mobileNumber: map['mob'],
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        "name": name,
        'age': age,
        "uId": uId,
        'domain': domain,
        "mob": mobileNumber,
      };
}
