import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:resto/User/models/favorite_list.dart';
import '../Pages/Cart.dart';
import '../components/menu_card.dart';
import '../models/cart_list.dart';
import '../models/food.dart';
import '../theme/app_color.dart';
import '../API/MenuAPI.dart';
import '../Pages/item.dart';

int sliding = 0;
Future<List<FoodData>> futureItems = fetchAllItems();

class Menu extends StatefulWidget {
  // int selectedPage;
  Function update;
  Menu({super.key, required this.update});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<List<FoodData>> futureFavorites = fetchFavorites();
  Future<List<CategoryData>> futureCategories = fetchCatagories();
  List<CategoryData> categories = [
    const CategoryData(categoryId: 100000, catagoryName: 'All'),
  ];
  final ScrollController yourScrollController = ScrollController();

  // Future<Widget> getCategories() async {
  //   categories.addAll(await fetchCatagories());
  // }

  void update() {
    setState(() {});
  }

  // @override
  // void dd() {
  //   setState(() {
  //     if (sliding == 0) {
  //       futureItems = fetchAllItems();
  //     } else {
  //       futureItems = fetchItemsByCategory(categories[sliding].categoryId);
  //     }
  //   });
  // }
  Future<void> _refresh() async {
    return await Future.delayed(Duration(seconds: 1))
        .whenComplete(() => setState(() {
              futureItems = fetchAllItems();
              futureFavorites = fetchFavorites();
              futureCategories = fetchCatagories();
            }));
  }

  @override
  Widget build(BuildContext context) {
    // final Future<List<FoodData>> list =
    //     fetchFoodData("http://localhost:3000/RESTO");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Menu",
            style: GoogleFonts.aladin(
              color: AppColorsLight.primaryColor,
              fontSize: 45,
            )),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) => Cart(),
                      ))
                      .whenComplete(() => update);
                },
                icon: Tooltip(
                  message: 'Go To Cart',
                  child: Icon(
                    (CartList.count == 0)
                        ? Icons.shopping_cart_outlined
                        : Icons.shopping_cart,
                    color: AppColorsLight.primaryColor,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppColorsLight.appBarColor,
        backgroundColor: AppColorsLight.primaryColor,
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
              child: SizedBox(
                height: 50,
                child: SearchAnchor(
                  viewHintText: "Search",
                  viewConstraints: BoxConstraints(maxHeight: 250),
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor: MaterialStateProperty.all(
                          AppColorsLight.primaryColor.shade500),
                      hintText: "Search for your food..",
                      hintStyle: MaterialStateProperty.all(
                          TextStyle(color: AppColorsLight.lightColor)),
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search,
                          color: AppColorsLight.lightColor),
                    );
                  },
                  suggestionsBuilder: (BuildContext context,
                      SearchController controller) async {
                    var list = await searchItem(controller.text);
                    var tiles = List<ListTile>.generate(list.length, (index) {
                      return ListTile(
                        title: Text(list[index].name),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                builder: (context) => Item(
                                  food: list[index],
                                ),
                              ))
                              .whenComplete(() => setState(
                                    () {},
                                  ));
                        },
                      );
                    });

                    return tiles;
                  },
                ),
              ),
            ),
            FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container();
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      categories.addAll(snapshot.data!);
                      return Padding(
                        padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                        child: CupertinoSlidingSegmentedControl(
                          backgroundColor: AppColorsLight.primaryColor.shade300,
                          thumbColor: AppColorsLight.primaryColor.shade600,
                          children: Map.fromIterable(categories,
                              key: (v) => categories.indexOf(v),
                              value: (v) => Text(
                                    v.catagoryName,
                                    style: GoogleFonts.alata(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColorsLight.lightColor,
                                    ),
                                  )),
                          groupValue: sliding,
                          onValueChanged: (value) {
                            setState(() {
                              sliding = value!;
                              switch (value) {
                                case (0):
                                  futureItems = fetchAllItems();
                                case (int()):
                                  futureItems = fetchItemsByCategory(
                                      categories[value].categoryId);
                              }
                            });
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                    // return snapshot.data ?? Container();
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(height: 5),
            Flexible(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: FutureBuilder(
                      future: Future.wait([futureItems, futureFavorites]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasError) {
                          return Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Error: Request to server failed',
                                style: TextStyle(fontSize: 20),
                              ));
                        } else if (snapshot.hasData) {
                          FavoriteList.setItems(snapshot.data![1]);
                          if (snapshot.data![0].isEmpty) {
                            return Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Empty',
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
                                itemCount: snapshot.data![0].length,
                                itemBuilder: (context, index) {
                                  if (index == snapshot.data![0].length - 1) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        MenuCard(
                                          food: snapshot.data![0][index],
                                        ),
                                        const SizedBox(height: 100)
                                      ],
                                    );
                                  } else {
                                    return MenuCard(
                                      food: snapshot.data![0][index],
                                    );
                                  }
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
                      }) //buildCategory(list)

                  ),
            )
          ],
        ),
      ),
    );
  }
}
