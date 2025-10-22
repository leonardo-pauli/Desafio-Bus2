import 'dart:convert';
import 'dart:async';

import 'package:desafio_bus2/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://randomuser.me/api/';

  Future<UserModel> fetchUser() async {
    try{
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 10));

      if(response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        final apiResponse = UserApiResponse.fromJson(jsonResponse);

        if(apiResponse.results.isNotEmpty) {
          return apiResponse.results.first;
        } else{
          throw Exception('Nenhum Usuário encontrado na resposta da API.');
        }
      } else {
        throw Exception('Falha ao carregar usuário: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Tempo de conexão esgotado. Verifique sua internet e tente novamente.');
    } catch(e){
      throw Exception('Erro de rede ou parsing: $e');
    }
  }
}