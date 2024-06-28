import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_respone_model.dart';
import 'package:ecommerce_app/services/category_service.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();
  bool _isLoading = false;
  List<Product> _products = [];
  final List<CategoryModel> _categories = [CategoryModel(id: -1, name: "All")];
  int _activeCategory = -1;

  bool get isLoading => _isLoading;
  int get activeCategory => _activeCategory;
  List<Product> get products => _products;
  List<CategoryModel> get categories => _categories;

  void changeActiveCategory(int categoryId) {
    _activeCategory = categoryId;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();
      _products = await _productService.fetchProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      _isLoading = true;
      notifyListeners();
      _products = await _productService.fetchProductsByCategory(categoryId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();

      final newCategories = await _categoryService.fetchCategories();
      _categories.addAll(newCategories);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
