import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:equatable/equatable.dart';

class UserApiResponse extends Equatable {
  final List<UserModel> results;

  const UserApiResponse({required this.results});

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      results: (json['results'] as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [results];
}

class UserModel extends Equatable {
  final Name name;
  final String email;
  final String phone;
  final Picture picture;
  final Location location;
  final Dob dob;
  final Login login;

  const UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.picture,
    required this.location,
    required this.dob,
    required this.login,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: Name.fromJson(json['name']),
      phone: json['phone'],
      picture: Picture.fromJson(json['picture']),
      location: Location.fromJson(json['location']),
      dob: Dob.fromJson(json['dob']),
      login: Login.fromJson(json['login']),
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
      pictureMedium: picture.medium,
      street: '${location.street.number} ${location.street.name}',
      city: location.city,
      state: location.state,
      country: location.country,
      postcode: location.postcode.toString(),
      dobDate: dob.date,
      dobAge: dob.age,
      username: login.username,
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

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(title: json['title'], first: json['first'], last: json['last']);
  }

  @override
  List<Object?> get props => [title, first, last];
}

class Picture extends Equatable {
  final String large;
  final String medium;

  const Picture({required this.large, required this.medium});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(large: json['large'], medium: json['medium']);
  }

  @override
  List<Object?> get props => [large, medium];
}

class Location extends Equatable {
  final Street street;
  final String city;
  final String state;
  final String country;
  final dynamic postcode;
  const Location({
    required this.city,
    required this.country,
    required this.postcode,
    required this.state,
    required this.street,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: Street.fromJson(json['street']),
      city: json['city'],
      country: json['country'],
      postcode: json['postcode'],
      state: json['state'],
    );
  }

  @override
  List<Object?> get props => [street, city, state, country, postcode];
}

class Street extends Equatable {
  final String name;
  final int number;

  const Street({required this.name, required this.number});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(name: json['name'], number: json['number']);
  }
  @override
  List<Object?> get props => [number, name];
}

class Dob extends Equatable {
  final String date;
  final int age;

  const Dob({required this.date, required this.age});

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(date: json['date'], age: json['age']);
  }
  @override
  List<Object?> get props => [date, age];
}

class Login extends Equatable {
  final String username;

  const Login({required this.username});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(username: json['username']);
  }
  @override
  List<Object?> get props => [username];
}
