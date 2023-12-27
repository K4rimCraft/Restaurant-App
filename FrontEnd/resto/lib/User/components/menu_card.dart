import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto/User/models/cart_list.dart';
import '../Pages/Cart.dart';
import '../Pages/item.dart';
import '../models/favorite_list.dart';
import '../models/food.dart';
import '../theme/app_color.dart';
import 'package:resto/main.dart';
import '../API/MenuAPI.dart';

class MenuCard extends StatefulWidget {
  final FoodData food;
  const MenuCard({
    super.key,
    required this.food,
  });

  @override
  State<MenuCard> createState() => _FoodTileState();
}

class _FoodTileState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(23),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => Item(
                  food: widget.food,
                ),
              ))
              .whenComplete(() => setState(() {}));
        },
        child: Ink(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Tooltip(
              message: widget.food.name,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 120,
                          child: Image.network(
                            '$serverUrl/images/${widget.food.firstImage}',
                            width: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.food.name,
                                maxLines: 1,
                                style: GoogleFonts.dmSerifDisplay(
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '\$' + widget.food.price.toString(),
                                style: GoogleFonts.dmSerifDisplay(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 7),
                              RatingBarIndicator(
                                rating: widget.food.rating,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: AppColorsLight.primaryColor,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton.filledTonal(
                          onPressed: () async {
                            if (FavoriteList.items.contains(widget.food)) {
                              await deleteFavorite(widget.food.itemId);
                            } else {
                              await sendFavorite(widget.food.itemId);
                            }

                            FavoriteList.setItems(await fetchFavorites());
                            setState(() {});
                          },
                          icon: Icon(
                            FavoriteList.items.contains(widget.food)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: FavoriteList.items.contains(widget.food)
                                ? AppColorsLight.primaryColor
                                : Colors.black,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Consumer<Cart>(
                          builder: (context, cart, child) {
                            return IconButton.filledTonal(
                              onPressed: () {
                                setState(() {
                                  if (CartList.items.contains(widget.food)) {
                                    cart.delete(widget.food);
                                  } else {
                                    cart.add(widget.food);
                                  }
                                });
                              },
                              icon: Icon(
                                !CartList.items.contains(widget.food)
                                    ? Icons.add
                                    : Icons.shopping_cart_checkout,
                                color: !CartList.items.contains(widget.food)
                                    ? Colors.black
                                    : Colors.deepOrange,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
