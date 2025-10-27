import 'package:desafio_bus2/core/database/database_helper.dart';
import 'package:desafio_bus2/core/service/api_service.dart';
import 'package:desafio_bus2/core/theme/app_theme.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/data/repositories/user_repository_impl.dart';
import 'package:desafio_bus2/presentation/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    final DatabaseHelper databaseHelper = DatabaseHelper();
    final ApiService apiService = ApiService();
    final UserRepository userRepository = UserRepositoryImpl(
      apiService: apiService, 
      databaseHelper: databaseHelper,
      );

    return RepositoryProvider<UserRepository>(
      create: (context) => userRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Desafio Flutter',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
      );
  }
}
