import 'dart:convert';
import 'package:ecommerce_app/models/product_favorite_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../core/auth.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();

  factory FavoriteService() {
    return _instance;
  }

  FavoriteService._internal();

  Future<List<ProductFavoriteModel>> fetchFavorites() async {
    final token = AuthService().getToken();
    final url = Uri.parse('$API_BASE_URL/users/favorites/');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProductFavoriteModel> products =
          data.map((json) => ProductFavoriteModel.fromJson(json)).toList();
      return products;
    } else {
      throw Exception("Failed to fetch Favorites");
    }
  }

  Future<bool> toggleFavorite(int productId) async {
    final token = AuthService().getToken();
    final url = Uri.parse('$API_BASE_URL/users/favorites/$productId');
    final headers = {
      "Authorization": "Bearer $token",
    };

    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to toggle Favorite");
    }
  }
}
