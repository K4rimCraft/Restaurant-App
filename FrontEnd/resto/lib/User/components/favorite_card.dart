import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:resto/User/API/MenuAPI.dart';
import '../Pages/item.dart';
import '../models/favorite_list.dart';
import '../models/food.dart';
import '../theme/app_color.dart';
import 'package:resto/main.dart';

class FavoriteCard extends StatefulWidget {
  final FoodData food;
  final Function update;
  const FavoriteCard({super.key, required this.food, required this.update});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
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
              .whenComplete(() => setState(
                    () {
                      widget.update();
                    },
                  ));
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
                          width: 120,
                          child: Image.network(
                            '$serverUrl/images/${widget.food.firstImage}',
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
                            await deleteFavorite(widget.food.itemId);
                            setState(() {
                              widget.update();
                            });
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
