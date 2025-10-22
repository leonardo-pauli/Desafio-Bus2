import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required UserModel user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
      ),
      body: const Center(
        child: Text('Tela de Detalhes'),
      ),
    );
  }
}