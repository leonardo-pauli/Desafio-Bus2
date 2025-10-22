import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/home/home_cubit.dart';
import 'package:desafio_bus2/presentation/viewmodels/home/home_state.dart';
import 'package:desafio_bus2/presentation/views/saved_users/saved_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userRepository = RepositoryProvider.of<UserRepository>(context);

        return HomeCubit(userRepository)..init(this);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Usuarios Aleatorios'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SavedUsersScreen()),
                );
              },
              icon: Icon(Icons.data_usage),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Erro ao carregar usuarios: ${state.message}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (state is HomeLoaded) {
              final users = state.users;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[users.length - 1 - index];
                  return _buildUserTile(context, user);
                },
              );
            }
            return const Center(child: Text('Nenhum usuario encontrado.'));
          },
        ),
      ),
    );
  }
  Widget _buildUserTile(BuildContext context, UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.picture.medium),
      ),
      title: Text('${user.name.first} ${user.name.last}'),
      subtitle: Text(user.email),
      onTap: (){
        print('Clicou em ${user.email}');
      },
    );
  }
}
