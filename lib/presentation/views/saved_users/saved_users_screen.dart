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
              return Center(child: Text('Erro: ${state.message}'),);
            }

            if(state is SavedUsersEmpty){
              return Center(
                child: Text('Nenhum usuario salvo no banco de dados.'),
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

Widget _buildUserTile(BuildContext context, UserDbModel user){
  return Dismissible(
    key: Key(user.id), 
    direction: DismissDirection.endToStart,

    onDismissed: (direction){
      context.read<SavedUsersCubit>().deleteUser(user.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.firstName} removido(a).'),
          backgroundColor: Colors.red,
          )
      );
    },
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.delete, color: Colors.white,),
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.pictureMedium),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),

      onTap: () async{
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsScreen(
              user: user.toUserModel(),
            ),
          ),
        );
        if(context.mounted){
          context.read<SavedUsersCubit>().loadSavedUsers();
        }
      },
    ),
    );
}
