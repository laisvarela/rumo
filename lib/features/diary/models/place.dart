import 'package:rumo/core/utils/string_utils.dart';
import 'package:rumo/features/diary/models/place_address.dart';

class Place {
  final double latitude;
  final double longitude;
  final String name;
  final PlaceAddress? address;

  Place({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.address,
  });

  // getter que retorna uma string formatada com nome e partes do endereço 
  String get formattedLocation {
    // inicializa o placeName com o nome, se não estiver vazio
    String placeName = name.isNotEmpty ? name : '';

    // se não houver endereço, retorna apenas o nome
    if(address == null) return placeName;

    // se haver rua, adiciona na string
    if(address!.road.isNotEmpty) {
      placeName += ' - ${address!.road}';
    }

    if(address!.city.isNotEmpty) {
      placeName += ' - ${address!.city}';
    }

    if(address!.state.isNotEmpty) {
      placeName += ' - ${address!.state}';
    }

    if(address!.country.isNotEmpty) {
      placeName += ' - ${address!.country}';
    }

    return placeName;
  }

  // cria um novo construtor nomeado para classe (nome = fromJson) 
  // bjetivo é retornar um objeto Place baseado no json que a API está trazendo
  // recebe um json por parâmetro
  factory Place.fromJson(Map<String, dynamic> json) {
    final lat = json['lat'] as String?;
    final lon = json['lon'] as String?;
    return Place(
      latitude: lat?.toDouble() ?? 0,
      longitude: lon?.toDouble() ?? 0,
      name: json['name'] ?? '',
      // se o endereço for diferente de nulo, converte para PlaceAdress que também contém um método fromJson e recebe um json como parametro
      address: json['address'] != null
          ? PlaceAddress.fromJson(json['address'])
          : null,
    );
  }

  // transforma cada objeto da lista recebida por paramtetro em um Place
  static List<Place> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Place.fromJson(json)).toList();
  }
}