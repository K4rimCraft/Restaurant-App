import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:resto/User/API/MenuAPI.dart';
import 'package:resto/User/MainPage.dart';
import 'Settings/Profile.dart';
import '../components/ads.dart';
import '../components/most_popular_card.dart';
import '../models/food.dart';
import '../theme/app_color.dart';
import '/User/Pages/Menu.dart';
import '../Pages/item.dart';

class MainPage extends StatefulWidget {
  final Function update;
  const MainPage({super.key, required this.update});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<FoodData>> futureAdsItems = fetchRandomItems();
  Future<List<FoodData>> futurePopulerItems = fetchMostPopularItems();
  Future<List<CategoryData>> futureCategories = fetchCatagories();

  Future<void> _refresh() async {
    return await Future.delayed(Duration(seconds: 1))
        .whenComplete(() => setState(() {
              futureCategories = fetchCatagories();
            }));
  }

  @override
  Widget build(BuildContext context) {
    final List chickenMenu = [];
    final List<Widget> ads = [];

    return Scaffold(
      backgroundColor: AppColorsLight.lightColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Resto",
            style: GoogleFonts.aladin(
              color: AppColorsLight.primaryColor,
              fontSize: 45,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(),
                ));
              },
              icon: Icon(
                Icons.person,
                color: AppColorsLight.lightColor,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppColorsLight.appBarColor,
        backgroundColor: AppColorsLight.primaryColor,

        // height: 150,
        // animSpeedFactor: 5,
        // showChildOpacityTransition: false,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: SearchAnchor(
                      viewBackgroundColor: AppColorsLight.primaryColor.shade100,
                      viewHintText: "Search",
                      viewConstraints: BoxConstraints(maxHeight: 250),
                      builder:
                          (BuildContext context, SearchController controller) {
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
                        var tiles =
                            List<ListTile>.generate(list.length, (index) {
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
                    future: futureAdsItems,
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
                          return Container();
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider(
                              items: snapshot.data!
                                  .map((item) => MyADS(
                                        food: item,
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 2.0,
                                enlargeCenterPage: false,
                              ),
                              carouselController: CarouselController(),
                            ),
                          );
                        }
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }
                    }),
                FutureBuilder(
                    future: futurePopulerItems,
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
                          return Container();
                        } else {
                          return Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Most Popular FoodData",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 230,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) =>
                                      MostPopularCard(
                                    food: snapshot.data![index],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }
                    }),

                /* Container(
                     decoration:BoxDecoration(
                       color: Colors.grey[100],
                       borderRadius: BorderRadius.circular(20)

                     ) ,
                     margin: EdgeInsets.only(left: 25,right: 25,bottom: 25),
                     padding: EdgeInsets.all(20),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Image.asset("lib/images/Strips.png",
                                 height: 60,fit: BoxFit.fill),
                             SizedBox(width: 20,),

                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Strips",style: GoogleFonts.dmSerifDisplay(fontSize: 20)),

                                 const SizedBox(height: 10,),

                                 Text("\$25",
                                   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700]
                                   ),
                                 )
                               ],
                             ),
                           ],
                         ),

                         Icon(Icons.favorite_outline,
                         color: Colors.grey,
                         size: 25),

                       ],
                     )
                   ),
                   */

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container();
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 100,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 2),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return buildCategries(
                                      index + 1,
                                      Icon(Icons.set_meal),
                                      snapshot.data![index].catagoryName,
                                      snapshot.data![index].categoryId);
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategries(
      int menuIndex, Icon icon, String catName, int categoryId) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        setState(() {
          sliding = menuIndex;
          if (sliding == 0) {
            futureItems = fetchAllItems();
          } else {
            futureItems = fetchItemsByCategory(categoryId);
          }
          widget.update(1);
        });
      },
      child: Ink(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: AppColorsLight.primaryColor.shade400,
                borderRadius: BorderRadiusDirectional.circular(20)),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  height: 5,
                ),
                Text(
                  catName,
                  style: GoogleFonts.dmSerifDisplay(
                    color: AppColorsLight.lightColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
