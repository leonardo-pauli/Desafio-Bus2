import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:equatable/equatable.dart';

class UserApiResponse extends Equatable{
  final List<UserModel> results;

  const UserApiResponse({required this.results});

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(results: (json['results'] as List)
    .map((userJson) => UserModel.fromJson(userJson))
    .toList(),
    );
  }

  @override
  List<Object?> get props => [results];
}

class UserModel extends Equatable{
  final Name name;
  final String email;
  final String phone;
  final Picture picture;

  const UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      email: json['email'], 
      name: Name.fromJson(json['name']), 
      phone: json['phone'], 
      picture: Picture.fromJson(json['picture']),
      );
  }

  UserDbModel toDbModel() {
    return UserDbModel(
      id: email,
      title: name.title,
      firstName: name.first,
      lastName: name.last,
      email: email,
      phone: phone,
      pictureLarge: picture.large,
      pictureMedium: picture.medium
    );
  }

  @override
  List<Object?> get props => [name, email, phone, picture];
}

class Name extends Equatable {
  final String title;
  final String first;
  final String last;

  const Name({required this.first, required this.last, required this.title});

  factory Name.fromJson(Map<String, dynamic> json){
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }

  @override
  List<Object?> get props => [title, first, last];
}

class Picture extends Equatable {
  final String large;
  final String medium;

  const Picture ({ required this.large, required this.medium });    

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'], 
      medium: json['medium'],
      );
  }

  @override
  List<Object?> get props => [large, medium];
}