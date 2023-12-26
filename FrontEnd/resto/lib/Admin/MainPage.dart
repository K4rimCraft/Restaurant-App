import 'package:flutter/material.dart';
import 'package:resto/Admin/EditMenu/Page.dart';
import 'package:resto/main.dart';
import 'package:resto/Admin/Overview/OverviewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminInterface extends StatefulWidget {
  AdminInterface({super.key});
  @override
  State<AdminInterface> createState() => _AdminInterfaceState();
}

class _AdminInterfaceState extends State<AdminInterface> {
  int currentPageIndex = 0;
  List<String> records = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (currentPageIndex) {
        0 => OverviewPage(),
        1 => EditMenuPage(),
        int() => Center(
            child: Container(
              child: ElevatedButton(
                child: Text('Sign Out'),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return MyApp();
                    }));
                  }
                },
              ),
            ),
          )
      },
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateTextStyle.resolveWith(
              (states) => const TextStyle(fontSize: 15)),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Theme.of(context).dividerColor,
          selectedIndex: currentPageIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_filled,
                color:
                    currentPageIndex == 0 ? Colors.grey[100] : Colors.grey[600],
              ),
              label: 'Main',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.restaurant_menu_outlined,
                color:
                    currentPageIndex == 1 ? Colors.grey[100] : Colors.grey[600],
              ),
              label: 'Restaurant',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.list_alt,
                color:
                    currentPageIndex == 2 ? Colors.grey[100] : Colors.grey[600],
              ),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }
}
