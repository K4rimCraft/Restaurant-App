import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/SignupData.dart';
import 'Pages/RegisterPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/WelcomePage.dart';
import 'package:resto/User/theme/app_color.dart';

class AuthInterface extends StatelessWidget {
  final Function update;
  const AuthInterface({Key? key, required this.update});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add your providers here
        ChangeNotifierProvider(create: (context) => s1_data()),
        ChangeNotifierProvider(create: (context) => s2_data()),
        ChangeNotifierProvider(create: (context) => s3_data()),
        ChangeNotifierProvider(create: (context) => forgot_data()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(update: update),
        theme: ThemeData(
          brightness:
              AppColorsLight.darkMode ? Brightness.dark : Brightness.light,
          useMaterial3: true,
          fontFamily: 'Bitter',
          colorSchemeSeed: Colors.deepOrange,
          sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always),
        ),
      ),
    );
  }
}
