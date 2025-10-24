import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:desafio_bus2/data/repositories/user_repository.dart';
import 'package:desafio_bus2/presentation/viewmodels/details/details_cubit.dart';
import 'package:desafio_bus2/presentation/viewmodels/details/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final UserModel user;

  const DetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = context.read<UserRepository>();
        return DetailsCubit(user, repository)..checkSavedStatus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.name.first} ${user.name.last}'),
          actions: [
            BlocBuilder<DetailsCubit, DetailsState>(
              builder: (context, state) {
                if (state is DetailsLoaded) {
                  return IconButton(
                    onPressed: () {
                      context.read<DetailsCubit>().toggleSave();
                    },
                    icon: Icon(state.isSaved ? Icons.delete : Icons.save),
                    color: state.isSaved ? Colors.red : null,
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            //principal
            _buildHeader(user),

            //login
            _buildSectionTitle(String, 'Informacoes de Login'),
            _buildInfoTile('Username', user.login.username),
            _buildInfoTile('Email', user.email),
            _buildInfoTile('Telefone', user.phone),

            //localizacao
            _buildSectionTitle(String, 'Localizacao'),
            _buildInfoTile('Endereco', 
            '${user.location.street.number} ${user.location.street.name}'),
            _buildInfoTile('Cidade', user.location.city),
            _buildInfoTile('Estado', user.location.state),
            _buildInfoTile('Pais', user.location.country),
            _buildInfoTile('CEP', user.location.postcode.toString()),

            //Pessoal
            _buildSectionTitle(String, 'Informacoes Pessoais'),
            _buildInfoTile('Data Nascimento', _formatDate(user.dob.date)),
            _buildInfoTile('Idade', '${user.dob.age} anos'),   
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader (UserModel user){
  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.picture.large),
          ),
          SizedBox(height: 16,),
          Text('${user.name.title} ${user.name.first} ${user.name.last}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
        ],
      ),
      ),
      
  );
}

Widget _buildSectionTitle(String, title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade700,
        fontSize: 14,
      ),
    ),
  );
}

Widget _buildInfoTile(String title, String subtitle) {
  return ListTile(
    title: Text(title),
    subtitle: Text(
      subtitle,
      style: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  );
}

String _formatDate(String isoDate){
  try{
    final dateTime = DateTime.parse(isoDate);

    return DateFormat('dd/MM/yyyy').format(dateTime);
  }catch(e){
    return isoDate;
  }
}
