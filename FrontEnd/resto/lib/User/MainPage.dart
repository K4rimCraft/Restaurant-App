import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '/User/Pages/Cart.dart';
import '/User/theme/app_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '/User/Pages/Booking/Booking.dart';
import '/User/Pages/MainPage.dart';
import '/User/Pages/Menu.dart';
import '/User/Pages/Settings/Settings.dart';
import '/User/Pages/Orders/Pages/Orders_Page.dart';

class UserInterface extends StatefulWidget {
  int selectedPage;
  Function updateTheme;
  // int sliding;
  UserInterface(
      {super.key, required this.selectedPage, required this.updateTheme});
  @override
  State<UserInterface> createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> {
  void update(int selectedPage) {
    setState(() {
      widget.selectedPage = selectedPage;
      // widget.sliding = sliding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Cart(),
        child: Scaffold(
          // bottomNavigationBar: CurvedNavigationBar(
          //     backgroundColor: Colors.transparent,
          //     color: AppColorsLight.primaryColor,
          //     animationDuration: Duration(milliseconds: 400),
          //     onTap: (value) {
          //       setState(() {
          //         widget.selectedPage = value;
          //       });
          //     },
          //     index: widget.selectedPage,
          //     items: const [
          //       Tooltip(
          //           message: "Main Page",
          //           child: Icon(Icons.home, color: AppColorsLight.lightColor)),
          //       Tooltip(
          //           message: "Menu",
          //           child: Icon(Icons.restaurant_menu,
          //               color: AppColorsLight.lightColor)),
          //       Tooltip(
          //           message: "Booking",
          //           child: Icon(Icons.table_restaurant,
          //               color: AppColorsLight.lightColor)),
          //       Tooltip(
          //           message: "Settings",
          //           child:
          //               Icon(Icons.settings, color: AppColorsLight.lightColor)),
          //     ]),

          /*Container(
          padding: EdgeInsets.only(right: 25,left: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColorsLight.primaryColor
          ),
          child: NavigationBar(
              destinations: [
            NavigationDestination(icon: Icon(Icons.home),label: "Home",),
            NavigationDestination(icon: Icon(Icons.restaurant_menu),label: "Menu",),
            NavigationDestination(icon: Icon(Icons.table_restaurant),label: "Booking",),
            NavigationDestination(icon: Icon(Icons.settings),label: "Settings",),
          ],

            selectedIndex:widget.selectedPage,

            onDestinationSelected: (value) {
              setState(() {
                widget.selectedPage=value;
              });
            },
            backgroundColor: Colors.transparent,
            height: 65,
            indicatorColor: AppColorsLight.primaryColor.shade300,
            elevation: 0,
          ),
        ),*/

          body: Stack(
            children: [
              <Widget>[
                MainPage(update: update),
                Menu(update: update),
                Booking(),
                ShowOrderPage(),
                Settings(
                    selectedPage: widget.selectedPage,
                    updateTheme: widget.updateTheme),
              ][widget.selectedPage],
              Container(
                alignment: Alignment.bottomCenter,
                child: CurvedNavigationBar(
                    backgroundColor: Colors.transparent,
                    color: AppColorsLight.primaryColor,
                    animationDuration: Duration(milliseconds: 400),
                    onTap: (value) {
                      setState(() {
                        widget.selectedPage = value;
                      });
                    },
                    index: widget.selectedPage,
                    items: const [
                      Tooltip(
                          message: "Main Page",
                          child: Icon(Icons.home,
                              color: AppColorsLight.lightColor)),
                      Tooltip(
                          message: "Menu",
                          child: Icon(Icons.restaurant_menu,
                              color: AppColorsLight.lightColor)),
                      Tooltip(
                          message: "Booking",
                          child: Icon(Icons.table_restaurant,
                              color: AppColorsLight.lightColor)),
                      Tooltip(
                          message: "Orders",
                          child: Icon(Icons.shopping_bag,
                              color: AppColorsLight.lightColor)),
                      Tooltip(
                          message: "Settings",
                          child: Icon(Icons.settings,
                              color: AppColorsLight.lightColor)),
                    ]),
              )
            ],
          ),
        ));
  }
}
