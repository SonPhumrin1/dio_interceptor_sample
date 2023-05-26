// {"id":3,"name":"Aanjaneya Menon","email":"menon_aanjaneya@rath.biz","gender":"male","status":"active"}

enum Gender { male, female }

enum Status { active, inactive }

class User {
  final int? id;
  final String name;
  final String email;
  final String gender;
  final String status;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
    );
  }
}
