import 'package:assignment_2/models/products.dart';
import 'package:flutter/material.dart';

class Product extends ChangeNotifier{
  List<Products> _items = [];

  List<Products> get items => _items;

  List<Products> _toshowdata = [];
  List<Products> get toshowdata => _toshowdata;

  List<Products> _favs = [];
  List<Products> get favs => _favs;

  int get itemcount => _items.length;

  void addproduct(Products p){
    _items.add(p);
    notifyListeners();
  }

  void toggleisfav(int index){
    _items[index].isFav = !_items[index].isFav;
    notifyListeners();
  }

  void ediproduct(Products p, int index){
    _items[index] = p;
    notifyListeners();
  }

}