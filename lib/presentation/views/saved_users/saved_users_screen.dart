import 'package:desafio_bus2/core/widgets/empty_state_display.dart';
import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/saved_users/saved_users_cubit.dart';
import 'package:desafio_bus2/presentation/viewmodels/saved_users/saved_users_state.dart';
import 'package:desafio_bus2/presentation/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedUsersScreen extends StatelessWidget {
  const SavedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        final repository = context.read<UserRepository>();
        return SavedUsersCubit(repository)..loadSavedUsers();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Usuarios Salvos'),
        ),
        body: BlocBuilder<SavedUsersCubit, SavedUsersState>(
          builder: (context, state){
            if(state is SavedUsersLoading){
              return Center(child: CircularProgressIndicator(),);
            }

            if(state is SavedUsersError){
              return const EmptyStateDisplay(
                icon: Icons.error_outline_rounded, 
                title: 'Erro no Banco de Dados', 
                subtitle: 'Não foi possível carregar seus usuários.');
            }

            if(state is SavedUsersEmpty){
              return const EmptyStateDisplay(
                icon: Icons.person_search_rounded, 
                title: 'Nenhum Usuário Salvo', 
                subtitle: 'Vá para a tela inicial, encontre usuários e salve-os para que apareçam aqui.',
                );
            }

            if(state is SavedUsersLoaded){
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index){
                  final user = state.users[index];
                  return _buildUserTile(context, user);
                }
                );
                
            }
            return Container();
          },
        ),
      ),
      );
  }
}

  Widget _buildUserTile(BuildContext context, UserDbModel user) {
    return Dismissible(
      key: Key(user.id),
      direction: DismissDirection.endToStart,
      
      onDismissed: (direction) {
        context.read<SavedUsersCubit>().deleteUser(user.id);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${user.firstName} removido(a).'),
            backgroundColor: Colors.red,
          ),
        );
      },
      
      // O "fundo" vermelho. Vamos deixá-lo com bordas arredondadas.
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      
      // O Card é o filho do Dismissible
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(user.pictureMedium),
          ),
          title: Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(user.email),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetailsScreen(
                  user: user.toUserModel(),
                ),
              ),
            );

            if (context.mounted) {
              context.read<SavedUsersCubit>().loadSavedUsers();
            }
          },
        ),
      ),
    );
  }
