import 'package:chairs/ui_screens/chairs_management/details_screen/details.dart';
import 'package:chairs/ui_screens/home.dart';
import 'package:chairs/ui_screens/splash.dart';
import 'package:flutter/widgets.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SplashScreen(),
  "home": (BuildContext context) => HomeScreen(),
  "DetailsScreen": (BuildContext context) => DetailsScreen(),

};