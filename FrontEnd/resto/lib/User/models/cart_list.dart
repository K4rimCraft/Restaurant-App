import '../models/food.dart';

class CartList {
  static List<FoodData> _items = [];
  static double _price = 0.0;
  static double _oldPrice = 0.0;
  static double? _descount;
  static String coupon = "Resto";
  static bool? couponstate;

  static void add(FoodData item) {
    item.quantity++;
    if (!_items.contains(item)) {
      _items.add(item);
    }
  }

  static void delete(FoodData item) {
    item.quantity = 0;
    _items.remove(item);
  }

  static int get count {
    return _items.length;
  }

  static double get totalPrice {
    _price = 0.0;
    for (FoodData x in _items) {
      _price += x.price * x.quantity;
    }
    if (couponstate == true && _descount != null) {
      _price = _price - (_price / _descount!);
    }
    return _price;
  }

  static double get oldTotalPrice {
    _oldPrice = 0.0;
    for (FoodData x in _items) {
      _oldPrice += x.price * x.quantity;
    }
    return _oldPrice;
  }

  static List<FoodData> get items {
    return _items;
  }

  static clear() {
    _items.clear();
    _price = 0.0;
  }

  static updatePrice(double descount) {
    _descount = descount;
    couponstate = true;
  }
}
