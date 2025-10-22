import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:desafio_bus2/data/models/user_model.dart';

abstract class UserRepository {

  Future<UserModel> getRemoteUser();

  Future<void> saveUser(UserModel user);

  Future<void> deleteUser(String id);

  Future<List<UserDbModel>> getSavedUsers();

  Future<bool> isUserSaved(String id);
}