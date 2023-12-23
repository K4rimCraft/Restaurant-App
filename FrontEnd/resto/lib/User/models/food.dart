class FoodData {
  static double maxPrice = 1000;
  static double maxTimesOrdered = 100;
  final int itemId;
  final String name;
  final int stock;
  final String description;
  final double rating;
  final double price;
  final int timesOrdered;
  final String firstImage;
  final String secondImage;
  int quantity;
  //List<CategoryData>? catagories;

  FoodData({
    required this.itemId,
    required this.name,
    required this.description,
    required this.rating,
    required this.price,
    required this.timesOrdered,
    required this.stock,
    required this.firstImage,
    required this.secondImage,
    required this.quantity,
    //this.catagories,
  });

  static List<FoodData> toList(List<dynamic> data) {
    List<FoodData> card = [];
    for (int i = 0; i < data.length; i++) {
      try {
        card.add(FoodData(
          itemId: data[i]['itemId'],
          name: data[i]['name'],
          description: data[i]['description'],
          rating: data[i]['rating'] + .0,
          price: data[i]['price'] + .0,
          timesOrdered: data[i]['timesOrdered'],
          stock: data[i]['stock'],
          firstImage: data[i]['firstImage'],
          secondImage: data[i]['secondImage'],
          quantity: 0,
          //catagories: CategoryData.toList(data[i]['categories']),
        ));
      } catch (err) {
        print(err);
      }
    }
    return card;
  }

  static String toItemCart(List<FoodData> data) {
    String json = '[';
    for (int i = 0; i < data.length; i++) {
      json =
          '$json{"itemId": ${data[i].itemId},"quantity": ${data[i].quantity} },';
    }
    json = json.substring(0, json.length - 1);
    json = json + ']';
    return json;
  }

  static FoodData emptyObj() {
    return FoodData(
      itemId: 0,
      name: "",
      description: "",
      rating: 0,
      price: 0,
      timesOrdered: 0,
      stock: 0,
      quantity: 0,
      firstImage: "",
      secondImage: "",
    );
  }

  @override
  bool operator ==(Object other) => other is FoodData && itemId == other.itemId;
  @override
  int get hashCode => itemId.hashCode;
}

class CategoryData {
  final int categoryId;
  final String catagoryName;

  const CategoryData({
    required this.categoryId,
    required this.catagoryName,
  });

  static List<CategoryData> toList(List<dynamic> data) {
    List<CategoryData> card = [];
    for (int i = 0; i < data.length; i++) {
      try {
        card.add(CategoryData(
          categoryId: data[i]['categoryId'],
          catagoryName: data[i]['categoryName'],
        ));
      } catch (err) {
        print(err);
      }
    }

    return card;
  }

  static CategoryData emptyObj() {
    return const CategoryData(
      categoryId: 0,
      catagoryName: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'catagoryName': catagoryName,
    };
  }

  @override
  bool operator ==(Object other) =>
      other is CategoryData &&
      categoryId == other.categoryId &&
      catagoryName == other.catagoryName;
  @override
  int get hashCode => categoryId.hashCode ^ catagoryName.hashCode;
}
