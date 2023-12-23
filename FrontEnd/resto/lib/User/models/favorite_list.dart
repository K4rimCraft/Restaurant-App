import '../models/food.dart';

class FavoriteList {
  static List<FoodData> _items = [];

  static List<FoodData> get items {
    return _items;
  }

  static setItems(List<FoodData> items) {
    _items = items;
  }
}
