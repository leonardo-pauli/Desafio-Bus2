import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../viewmodels/details/details_cubit.dart';
import '../../viewmodels/details/details_state.dart';

class DetailsScreen extends StatelessWidget {
  final UserModel user;

  const DetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = context.read<UserRepository>();
        return DetailsCubit( user, repository)..checkSavedStatus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.name.first} ${user.name.last}'),
        ),
        
        floatingActionButton: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoaded) {
              return FloatingActionButton(
                onPressed: () {
                  context.read<DetailsCubit>().toggleSave();
                },
                backgroundColor: state.isSaved
                    ? Colors.red.shade700
                    : Theme.of(context).colorScheme.primary,
                child: Icon(
                  state.isSaved ? Icons.delete_forever : Icons.save,
                  color: Colors.white,
                ),
              );
            }
            return FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.grey.shade400,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
        ),
        
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, user),

              _buildInfoCard(
                context,
                title: 'Informações de Login',
                children: [
                  _buildInfoTile(
                    context,
                    title: 'Username',
                    subtitle: user.login.username,
                    icon: Icons.person_outline,
                  ),
                  _buildInfoTile(
                    context,
                    title: 'Email',
                    subtitle: user.email,
                    icon: Icons.email_outlined,
                  ),
                  _buildInfoTile(
                    context,
                    title: 'Telefone',
                    subtitle: user.phone,
                    icon: Icons.phone_outlined,
                  ),
                ],
              ),
              
              _buildInfoCard(
                context,
                title: 'Localização',
                children: [
                  _buildInfoTile(
                    context,
                    title: 'Endereço',
                    subtitle: '${user.location.street.number} ${user.location.street.name}',
                    icon: Icons.location_on_outlined,
                  ),
                  _buildInfoTile(
                    context,
                    title: 'Cidade / Estado',
                    subtitle: '${user.location.city}, ${user.location.state}',
                    icon: Icons.map_outlined,
                  ),
                  _buildInfoTile(
                    context,
                    title: 'País',
                    subtitle: user.location.country,
                    icon: Icons.public_outlined,
                  ),
                ],
              ),
              
              _buildInfoCard(
                context,
                title: 'Informações Pessoais',
                children: [
                  _buildInfoTile(
                    context,
                    title: 'Data Nasc.',
                    subtitle: _formatDate(user.dob.date),
                    icon: Icons.calendar_today_outlined,
                  ),
                  _buildInfoTile(
                    context,
                    title: 'Idade',
                    subtitle: '${user.dob.age} anos',
                    icon: Icons.cake_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel user) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.picture.large),
            ),
            const SizedBox(height: 16),
            Text(
              '${user.name.title} ${user.name.first} ${user.name.last}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
            ),
            const Divider(height: 20, thickness: 1),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, {required String title, required String subtitle, required IconData icon}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return isoDate;
    }
  }
}