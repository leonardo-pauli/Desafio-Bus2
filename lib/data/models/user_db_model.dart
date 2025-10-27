import 'package:equatable/equatable.dart';
import 'user_model.dart' show UserModel, Name, Picture, Location, Street, Dob, Login;

class UserDbModel extends Equatable {
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String pictureLarge;
  final String pictureMedium;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String dobDate;
  final int dobAge;
  final String username;

  const UserDbModel({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.dobDate,
    required this.dobAge,
    required this.username, 
    required this.email,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.phone,
    required this.pictureLarge,
    required this.pictureMedium,
    required this.title,
  });

  factory UserDbModel.fromMap(Map<String, dynamic> map) {
    return UserDbModel(
      id: map['id'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      pictureLarge: map['pictureLarge'] as String,
      pictureMedium: map['pictureMedium'] as String,
      title: map['title'] as String,
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      postcode: map['postcode'] as String,
      dobDate: map['dobDate'] as String,
      dobAge: map['dobAge'] as int,
      username: map['username'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'pictureLarge': pictureLarge,
      'pictureMedium': pictureMedium,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
      'dobDate': dobDate,
      'dobAge': dobAge,
      'username': username,
    };
  }

  UserModel toUserModel(){
    final streetParts = street.split(' ');
    final streetNumber = int.tryParse(streetParts.first) ?? 0;

    final streetName = streetParts.length > 1
    ? streetParts.skip(1).join(' ')
    : street;

    return UserModel(
      email: email, 
      name: Name(
        first: firstName, 
        last: lastName, 
        title: title,
        ), 
      phone: phone, 
      picture: Picture(
        large: pictureLarge, 
        medium: pictureMedium,
        ), 
      location: Location(
        city: city, 
        country: country, 
        postcode: postcode, 
        state: state, 
        street: Street(
          name: streetName, 
          number: streetNumber,
          ),
          ), 
      dob: Dob(
        date: dobDate, 
        age: dobAge,
        ), 
      login: Login(
        username: username,
        )
      );
  }

  @override
  List<Object?> get props => [id];
}
