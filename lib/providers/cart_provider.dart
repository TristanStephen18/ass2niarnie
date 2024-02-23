import 'package:assignment_2/models/cart.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier{

    List<CartItem> _items = [];

  List<CartItem> get items => _items;
  
  void add(CartItem cartItem) {
    var codeList = _items.map((item) => item.productCode).toList();
    var index = codeList.indexOf(cartItem.productCode);
    if (index < 0) {
      _items.add(cartItem);
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }

  void removeitem(int index){
    _items.removeAt(index);
    notifyListeners();
  }
}