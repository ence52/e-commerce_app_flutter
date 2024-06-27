import 'package:ecommerce_app/models/product_respone_model.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  bool _isLoading = false;
  List<Product> _products = [];

  bool get isLoading => _isLoading;
  List<Product> get products => _products;

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
}
