import 'dart:convert';
import 'package:ecommerce_app/core/shared_prefs.dart';
import 'package:ecommerce_app/models/product_cart_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  final token = SharedPrefs().prefs?.getString("token");
  factory CartService() {
    return _instance;
  }

  CartService._internal();

  Future<List<ProductCartResponseModel>> fetchProducts() async {
    final url = Uri.parse('$API_BASE_URL/carts/items/');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      List<ProductCartResponseModel> products =
          data.map((json) => ProductCartResponseModel.fromJson(json)).toList();
      print("*" * 100);
      print(products);
      return products;
    } else {
      throw Exception("Failed to fetch Products");
    }
  }

  Future<int> getCartItemCount() async {
    final url = Uri.parse('$API_BASE_URL/carts/item_count/');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to get ItemCount");
    }
  }

  Future<double> getCartTotalPrice() async {
    final url = Uri.parse('$API_BASE_URL/carts/total_price');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception("Failed to get TotalPrice");
    }
  }

  Future<int> getCartItemQuantityById(int productId) async {
    final url = Uri.parse('$API_BASE_URL/carts/items/$productId/quantity');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to get Item Quantity");
    }
  }

  Future<void> increaseItemQuantityById(int productId) async {
    final url = Uri.parse('$API_BASE_URL/carts/items/$productId/add');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to increase quantity");
    }
  }

  Future<void> decreaseItemQuantityById(int productId) async {
    final url = Uri.parse('$API_BASE_URL/carts/items/$productId/decrease');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to decrease quantity");
    }
  }

  Future<void> removeItemById(int productId) async {
    final url = Uri.parse('$API_BASE_URL/carts/items/$productId/all');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to remove quantity");
    }
  }
}
