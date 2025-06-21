class UserModel {
  final String name;
  final DateTime dob;
  final String phoneNumber;
  final String role;
  final String gender;
  final String email;
  final String country;
  final String language;

  UserModel({
    required this.name,
    required this.dob,
    required this.phoneNumber,
    required this.role,
    required this.gender,
    required this.email,
    required this.country,
    required this.language,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      gender: json['gender'],
      email: json['email'],
      country: json['country'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'dob': dob.toIso8601String(),
    'phoneNumber': phoneNumber,
    'role': role,
    'gender': gender,
    'email': email,
    'country': country,
    'language': language,
  };
}
