import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SavedUsersState extends Equatable{ 
  const SavedUsersState();

  @override
  List<Object> get props => [];
}

class SavedUsersLoading extends SavedUsersState {}

class SavedUsersLoaded extends SavedUsersState {
  final List<UserDbModel> users;

  const SavedUsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class SavedUsersEmpty extends SavedUsersState {}

class SavedUsersError extends SavedUsersState {
  final String message;

  const SavedUsersError(this.message);

  @override
  List<Object> get props => [message];
}