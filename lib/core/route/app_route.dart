import 'package:flutter/material.dart';

import 'route_key.dart';

class AppRoute {
  Route<dynamic> generateRoute(RouteSettings settings) {


    switch (settings.name) {
      // case RouteKey.onbourding:
      //   return MaterialPageRoute(builder: (_) => OnboardingScreen());
      // case RouteKey.home:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found for ${settings.name}')),
          ),
        );
    }
  }
  Map<String, Widget Function(BuildContext)> routes = {
    // RouteKey.onbourding: (context) => OnboardingScreen(),
    // RouteKey.home: (context) => HomeScreen(),
  };
}
