import 'package:desafio_bus2/core/database/database_helper.dart';
import 'package:desafio_bus2/core/service/api_service.dart';
import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{

  final ApiService apiService;
  final DatabaseHelper databaseHelper;

  UserRepositoryImpl({
    required this.apiService,
    required this.databaseHelper,
  });

  @override
  Future<UserModel> getRemoteUser() async{
    return await apiService.fetchUser();
  }

  @override
  Future<List<UserDbModel>> getSavedUsers() async {
    return await databaseHelper.getAllUsers();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userDb = user.toDbModel();
    await databaseHelper.saveUser(userDb);
  }

  @override
  Future<void> deleteUser(String id) async {
    await databaseHelper.deleteUser(id);
  }

  @override
  Future<bool> isUserSaved(String id) async {
    final user = await databaseHelper.getUser();
    return user != null;
  }
}