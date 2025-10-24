import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/saved_users/saved_users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class SavedUsersCubit extends Cubit<SavedUsersState> {
  final UserRepository _userRepository;

  SavedUsersCubit(this._userRepository) : super(SavedUsersLoading());

  Future<void> loadSavedUsers() async {
    try{
      emit(SavedUsersLoading());
      final users = await _userRepository.getSavedUsers();

      if(users.isEmpty){
        emit(SavedUsersEmpty());
      }else{
        emit(SavedUsersLoaded(users));
      }
    }catch(e){
      emit(SavedUsersError(e.toString()));
    }
  }

  Future<void> deleteUser(String id) async {
    final currentState = state;
    if(currentState is SavedUsersLoaded) {
      final updateList = currentState.users.where((user) => user.id != id).toList();

      if(updateList.isEmpty){
        emit(SavedUsersEmpty());
      }else{
        emit(SavedUsersLoaded(updateList));
      }

      try{
        await _userRepository.deleteUser(id);
      }catch(e){
        loadSavedUsers();
      }
    }
  }
}