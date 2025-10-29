import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/details/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState>{
  final UserRepository _userRepository;
  final UserModel _user;

  DetailsCubit (this._user, this._userRepository) : super(DetailsLoading());

  Future<void> checkSavedStatus() async {
    try{
      final isSaved = await _userRepository.isUserSaved(_user.email);
      emit(DetailsLoaded(isSaved: isSaved));
    } catch(e){
      emit (const DetailsLoaded(isSaved: false));
    }
  }

  Future<void> toggleSave() async {
    final currentState = state;
    if(currentState is DetailsLoaded){
      final bool currentSavedStatus = currentState.isSaved;

      try{
        if(currentSavedStatus){
          await _userRepository.deleteUser(_user.email);
        }else{
          await _userRepository.saveUser(_user);
        }

        emit(DetailsLoaded(isSaved: !currentSavedStatus));
      }catch(e){
        emit (DetailsActionFailure(message: e.toString(), isSaved: currentSavedStatus));
      }
    }

  }
}