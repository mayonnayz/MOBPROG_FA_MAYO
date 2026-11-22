
import 'dart:convert';
import 'package:fa5_creativity_app/models/biome.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class BiomeService {
  final String baseUrl = AppConstants.apiUrl;

  Future<List<Biome>> getBiomes({
    String? dimension,
    String? category,
    String? rarity,
    String? precipitation,
  }) async {
    final params = <String, String>{};

    if (dimension != null && dimension.isNotEmpty) {
      params['dimension'] = dimension;
    }

    if (category != null && category.isNotEmpty) {
      params['category'] = category;
    }

    if (rarity != null && rarity.isNotEmpty) {
      params['rarity'] = rarity;
    }

    if (precipitation != null && precipitation.isNotEmpty) {
      params['precipitation'] = precipitation;
    }

    final uri = Uri.parse(baseUrl).replace(
      queryParameters: params.isEmpty ? null : params,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      final List data = result is List
          ? result
          : (result['data'] ?? []);

      return data
          .map((item) => Biome.fromJson(item))
          .toList();
    }

    throw Exception('Failed to retrieve biomes');
  }
}
