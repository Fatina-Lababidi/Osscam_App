// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LogoutModel {
  String email;
  String password;
  LogoutModel({
    required this.email,
    required this.password,
  });

  LogoutModel copyWith({
    String? email,
    String? password,
  }) {
    return LogoutModel(
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

  factory LogoutModel.fromMap(Map<String, dynamic> map) {
    return LogoutModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoutModel.fromJson(String source) => LogoutModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LogoutModel(email: $email, password: $password)';

  @override
  bool operator ==(covariant LogoutModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
  }
