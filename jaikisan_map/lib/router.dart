import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///E:/shekhar%20workspace/jaikisan_map/lib/utils/app_contants.dart';
import 'file:///E:/shekhar%20workspace/jaikisan_map/lib/ui/home_screen.dart';

import 'ui/splash_screen.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.SplashScreen:
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case AppConstants.HomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}