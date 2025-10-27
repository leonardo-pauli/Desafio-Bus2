import 'package:desafio_bus2/core/widgets/empty_state_display.dart';
import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/home/home_cubit.dart';
import 'package:desafio_bus2/presentation/viewmodels/home/home_state.dart';
import 'package:desafio_bus2/presentation/views/details/details_screen.dart';
import 'package:desafio_bus2/presentation/views/saved_users/saved_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final HomeCubit _homeCubit;

  @override
  void initState(){
    super.initState();
    _homeCubit = HomeCubit(
      context.read<UserRepository>(),
    )..init(this);
  }

  @override
  void dispose(){
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
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
        body: RefreshIndicator(
          onRefresh: () => _homeCubit.refresh(this),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeError) {
                return const EmptyStateDisplay(
                  icon: Icons.wifi_off_rounded, 
                  title: 'Ops! Falha na conexão.', 
                  subtitle: 'Não foi possivel buscar novos usuários. Verifique sua internet e tente novamente.');
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
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, UserModel user) {
    return Card(
      elevation: 2.0, // Sombra suave
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(user.picture.medium),
        ),
        title: Text(
          '${user.name.first} ${user.name.last}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(user.email),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailsScreen(user: user),
          ));
        },
      ),
    );
  }
}
