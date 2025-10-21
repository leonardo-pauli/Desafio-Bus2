import 'package:equatable/equatable.dart';

class UserDbModel extends Equatable{
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String pictureLarge;
  final String pictureMedium;

  const UserDbModel ({
    required this.email,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.phone,
    required this.pictureLarge,
    required this.pictureMedium,
    required this.title
  });

  factory UserDbModel.fromMap(Map<String, dynamic> map){
    return UserDbModel(
      id: map['id'] as String, 
      email: map['email'] as String, 
      firstName: map['firstName'] as String, 
      lastName: map['lastName'] as String, 
      phone: map['phone'] as String, 
      pictureLarge: map['pictureLarge'] as String, 
      pictureMedium: map['pictureMedium'] as String, 
      title: map['title'] as String
      );
  }

  Map<String, dynamic> toMap(){
    return{
  'id': id,
  'title': title,
  'firstName': firstName,
  'lastName': lastName,
  'email': email,
  'phone': phone,
  'pictureLarge': pictureLarge,
  'pictureMedium': pictureMedium,
  };
}

@override
List<Object?> get props => [id, email];
}