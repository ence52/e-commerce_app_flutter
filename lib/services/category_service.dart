import 'dart:convert';

import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static final CategoryService _instance = CategoryService._internal();

  factory CategoryService() {
    return _instance;
  }

  CategoryService._internal();

  Future<List<CategoryModel>> fetchCategories() async {
    var url = Uri.parse('$API_BASE_URL/categories/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CategoryModel> categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception("Failed to fetch Categories");
    }
  }
}
