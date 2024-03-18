import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_review/firebase_options.dart';
import 'package:food_review/pages/authentication/user_login.dart';
import 'package:food_review/pages/home.dart';
import 'package:food_review/services/authentication_service.dart';
import 'package:food_review/state/authentication_state.dart';

import 'helper/routes.dart';
import 'helper/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: null,
      stream: AuthenticationService.userAuthStateChanges,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            if (snapshot.hasData) {
              return AuthenticationState(
                uid: snapshot.data.uid,
                child: const BuildMaterialApp(initialRoute: Home.route),
              );
            } else {
              return const BuildMaterialApp(initialRoute: UserLogin.route);
            }
          default:
            return const BuildMaterialApp(initialRoute: UserLogin.route);
        }
      },
    );
  }
}

class BuildMaterialApp extends StatelessWidget {
  const BuildMaterialApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      key: Key('${DateTime.now()}'),
      debugShowCheckedModeBanner: false,
      title: 'Food Reviews',
      theme: Themes.lightTheme(),
      darkTheme: Themes.darkTheme(),
      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey,
      initialRoute: initialRoute,
      routes: Routes.routes,
    );
  }
}
