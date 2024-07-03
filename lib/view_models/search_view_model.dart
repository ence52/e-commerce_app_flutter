import 'package:ecommerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

import '../models/product_respone_model.dart';

class SearchViewModel extends ChangeNotifier {
  final _productService = ProductService();

  bool _isLoading = false;
  bool _isSearchFailed = false;
  List<Product> _products = [];

  bool get isLoading => _isLoading;
  bool get isSearchFailed => _isSearchFailed;
  List<Product> get products => _products;

  void removeProducts() {
    _products = [];
    notifyListeners();
  }

  void setSearchFailed(bool b) {
    _isSearchFailed = b;
    notifyListeners();
  }

  Future<void> fetchProductsBySearchText(String searchText) async {
    try {
      _isLoading = true;
      notifyListeners();
      _products = await _productService.fetchProductsBySearchText(searchText);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
