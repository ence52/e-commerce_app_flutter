import 'package:ecommerce_app/models/product_cart_model.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();
  bool _isLoading = false;
  int _itemCount = 0;
  List<ProductCartResponseModel> _products = [];

  bool get isLoading => _isLoading;
  int get itemCount => _itemCount;
  List<ProductCartResponseModel> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();
      _products = await _cartService.fetchProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getItemCount() async {
    try {
      _isLoading = true;
      notifyListeners();
      _itemCount = await _cartService.getCartItemCount();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> getItemQuantity(int productId) async {
    try {
      _isLoading = true;

      int result = await _cartService.getCartItemQuantityById(productId);
      _isLoading = false;

      return Future.value(result);
    } catch (e) {
      _isLoading = false;

      throw Exception('Failed to get item quantity: $e');
    }
  }

  Future<double> getCartSubTotalPrice() async {
    try {
      _isLoading = true;

      double result = await _cartService.getCartTotalPrice();
      _isLoading = false;

      return result;
    } catch (e) {
      _isLoading = false;

      throw Exception('Failed to get Total Price: $e');
    }
  }

  Future<double> getCartTotalPrice() async {
    try {
      _isLoading = true;

      double result = await _cartService.getCartTotalPrice();
      result = result * .95;
      result += 13;
      result = double.parse(result.toStringAsFixed(2));
      _isLoading = false;

      return result;
    } catch (e) {
      _isLoading = false;

      throw Exception('Failed to get Total Price: $e');
    }
  }

  Future<void> increaseItemQuantityById(int productId) async {
    try {
      _isLoading = true;
      await _cartService.increaseItemQuantityById(productId);
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      throw Exception('Error: $e');
    }
    notifyListeners();
  }

  Future<void> decreaseItemQuantityById(int productId) async {
    try {
      _isLoading = true;
      await _cartService.decreaseItemQuantityById(productId);
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      throw Exception('Error: $e');
    }
    notifyListeners();
  }

  Future<void> removeProductFromCartList(int productId) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _cartService.removeItemById(productId);

      await fetchProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error: $e');
    }
  }

  Future<bool> isProductInCart(int productId) async {
    try {
      bool isInCart = _products.any((product) => product.id == productId);

      return isInCart;
    } catch (e) {
      throw Exception('Failed to check if product is in cart: $e');
    }
  }
}
