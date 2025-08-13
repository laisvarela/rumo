import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rumo/core/helpers/app_environment.dart';
import 'package:rumo/features/diary/models/place.dart';

class PlaceRepository {
  // declara uma variável client do tipo Dio, que será usada para fazer requisições HTTP
  // late final significa que ela será inicializada depois, mas só uma vez
  late final Dio client;

  PlaceRepository() {
    // inicializa o Dio e define a URL base da API Nominatim
    client = Dio(
      BaseOptions(
        baseUrl: 'https://nominatim.openstreetmap.org',
        // define os cabeçalhos HTTP para enviar e receber dados em formato JSON
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'RumoApp - ${AppEnvironment.placesAPIAgentName}', // identificador personalizado para a requisição
          'Accept-Language': 'pt-BR',
        },
      ),
    );
  }

  // método assíncrono que retorna uma lista de objetos Place
  // recebe uma query obrigatória (termo de busca)
  Future<List<Place>> getPlaces({required String query}) async {
    try {
      // faz uma requisição get para /search com os parâmetros abaixo
      final response = await client.get('/search', queryParameters: {
        'q': query, // termo
        'format': 'json', // formato da resposta
        'addressdetails': 1, // inclui detalhes do endereço
        'limit': 10, // limita a resposta a 10 resultados
      });

      // converte os dados recebidos em uma lista de objetos Place, usando um método estático fromJsonList do Place.dart
      return Place.fromJsonList(response.data);
    } catch (error, stackTrace) {
      log("Error fetching places", error: error, stackTrace: stackTrace);
      return [];
    }
  }
}