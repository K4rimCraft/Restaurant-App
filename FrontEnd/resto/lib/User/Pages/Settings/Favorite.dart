import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/favorite_card.dart';
import '../../models/favorite_list.dart';
import '../../theme/app_color.dart';
import '../../API/MenuAPI.dart';
import '../../models/food.dart';

class Favorite extends StatefulWidget {
  Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Future<List<FoodData>> futureFavorites = fetchFavorites();
  final ScrollController yourScrollController = ScrollController();

  void update() {
    futureFavorites = fetchFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsLight.lightColor,
        appBar: AppBar(
          elevation: 0,
          title: Text("Favorites",
              style: GoogleFonts.aladin(
                color: AppColorsLight.primaryColor,
                fontSize: 45,
              )),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios,
                color: AppColorsLight.primaryColor),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          ),
        ),
        body: FutureBuilder(
            future: futureFavorites,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Error: Request to server failed',
                      style: TextStyle(fontSize: 20),
                    ));
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'No Data within the specified filters',
                        style: TextStyle(fontSize: 20),
                      ));
                } else {
                  return Scrollbar(
                    controller: yourScrollController,
                    interactive: true,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: yourScrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return FavoriteCard(
                          food: snapshot.data![index],
                          update: update,
                        );
                      },
                    ),
                  );
                }
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
            }) //bu

        );
  }
}
