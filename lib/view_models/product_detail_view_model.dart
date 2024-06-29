import 'package:flutter/material.dart';

import '../models/product_respone_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  late Product _product;

  Product get product => _product;

  void setProduct(Product newProduct) {
    _product = newProduct;
  }
}
