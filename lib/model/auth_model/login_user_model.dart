// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginUserModel {
  String email;
  String password;
  LoginUserModel({
    required this.email,
    required this.password,
  });

  LoginUserModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginUserModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    return LoginUserModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUserModel.fromJson(String source) => LoginUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginUserModel(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginUserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
