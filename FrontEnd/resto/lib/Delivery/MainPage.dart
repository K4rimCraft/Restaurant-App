import 'package:flutter/material.dart';
import 'package:resto/Delivery/pages/assigned_order_page.dart';
import 'package:resto/Delivery/pages/available_order_page.dart';
import 'package:resto/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryInteface extends StatefulWidget {
  const DeliveryInteface({super.key});

  @override
  State<DeliveryInteface> createState() => _DeliveryIntefaceState();
}

class _DeliveryIntefaceState extends State<DeliveryInteface> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
  final List<Widget> _widgetOptions = <Widget>[
    const AvailableOrderPage(),
    AssignedOrderPage(),
    Center(
      child: Container(
        child: ElevatedButton(
          child: const Text('Sign Out'),
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
  ];

    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateTextStyle.resolveWith(
              (states) => const TextStyle(fontSize: 15)),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: _onItemTapped,
          indicatorColor: Theme.of(context).dividerColor,
          selectedIndex: _selectedIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_filled,
                color:
                    _selectedIndex == 0 ? Colors.grey[100] : Colors.grey[600],
              ),
              label: 'Available',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.history,
                color:
                    _selectedIndex == 1 ? Colors.grey[100] : Colors.grey[600],
              ),
              label: 'Current',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                color:
                    _selectedIndex == 2 ? Colors.grey[100] : Colors.grey[600],
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

// BottomNavigationBar(
//           backgroundColor: Colors.brown.shade900,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//               ),
//               label: 'Available',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.history,
//               ),
//               label: 'Current',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.settings,
//               ),
//               label: 'Settings',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           onTap: _onItemTapped,
//         ),