import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/home/home_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>{
  final UserRepository _userRepository;
  Ticker? _ticker;

  final List<UserModel> _userList = [];

  static const _fetchInterval = Duration(seconds: 5);
  Duration _lastFetchTime = Duration.zero;

  HomeCubit(this._userRepository) : super(HomeInitial());

  void init(TickerProvider vsync) {
    _fetchAndAddUser();

    _ticker = vsync.createTicker(_onTick);
    _ticker?.start();
  }

  Future<void> refresh(TickerProvider vsync) async {
    _ticker?.dispose();
    _ticker = null;

    _lastFetchTime = Duration.zero;

    emit(HomeLoading());

    _ticker = vsync.createTicker(_onTick);
    _ticker?.start();

    await _fetchAndAddUser();
  }

  void _onTick(Duration elapsed) {
    if(elapsed - _lastFetchTime >= _fetchInterval){
      _lastFetchTime = elapsed;
      _fetchAndAddUser();
    }
  }

  Future<void> _fetchAndAddUser() async {
    if(_userList.isEmpty){
      emit(HomeLoading());
    }

    try{
      final newUser = await _userRepository.getRemoteUser();

      _userRepository.saveUser(newUser);

      _userList.add(newUser);

      emit(HomeLoaded(List.from(_userList)));
    }catch(e){
      emit(HomeError(e.toString()));
      _ticker?.stop();
    }
  }

  @override
  Future<void> close(){
    _ticker?.dispose();
    return super.close();
  }
}