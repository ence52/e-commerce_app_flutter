import 'package:ecommerce_app/services/favorite_service.dart';
import 'package:flutter/foundation.dart';

import '../models/product_favorite_model.dart';
import '../models/user_info.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  bool _isLoading = false;
  List<ProductFavoriteModel> _favorites = [];

  List<ProductFavoriteModel> get favorites => _favorites;
  bool get isLoading => _isLoading;

  UserInfoModel? user;
  FavoritesViewModel(this.user);

  void updateUser(UserInfoModel? newUser) {
    user = newUser;
    notifyListeners();
  }

  Future<void> fetchFavorites() async {
    try {
      _isLoading = true;
      notifyListeners();
      _favorites = await _favoriteService.fetchFavorites();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(int productId) async {
    try {
      _isLoading = true;
      notifyListeners();
      bool result = await _favoriteService.toggleFavorite(productId);
      if (result) {
        fetchFavorites();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isInFavorites(int productId) {
    bool isInCart = _favorites.any((product) => product.id == productId);
    return isInCart;
  }
}
