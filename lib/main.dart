import 'package:chairs/provider/home_provider.dart';
import 'package:chairs/routes.dart';
import 'package:chairs/services/database_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/db_model.dart';
import 'navigation_service.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<ChairModel>>.value(
            value: DatabaseService().getLiveChairs),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'Chairs',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.instance.key,
        initialRoute: '/',
        theme: appTheme(),
        routes: routes,
      ),
    );
  }
}
