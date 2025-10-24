import 'package:flutter/material.dart';

class SavedUsersScreen extends StatelessWidget {
  const SavedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários Salvos'),
      ),
      body: const Center(
        child: Text('Tela de Usuários Persistidos'),
      ),
    );
  }
}
