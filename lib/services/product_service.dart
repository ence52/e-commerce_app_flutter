import 'dart:convert';

import 'package:ecommerce_app/models/product_respone_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> fetchProducts() async {
    var url = Uri.parse('$API_BASE_URL/products/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception("Failed to fetch Products");
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    var url = Uri.parse('$API_BASE_URL/categories/$categoryId/products');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception("Failed to fetch Products");
    }
  }

  Future<List<Product>> fetchProductsBySearchText(String searchText) async {
    var url = Uri.parse('$API_BASE_URL/products/search/$searchText');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception("Failed to fetch Products");
    }
  }
}
