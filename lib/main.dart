import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:worden/models/database/cache.dart';
import 'package:worden/pages/auth_page.dart';
import 'package:worden/pages/home_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Cache.initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Cache.getPreferencesListenable(),
        builder: (context, box, widget) {
          return MaterialApp(
            themeMode: box.get("darkMode", defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
              textTheme: GoogleFonts.poppinsTextTheme(),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  opacity: 0.8,
                  size: 25,
                ),
                titleTextStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                centerTitle: true,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: Colors.black,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.orange.shade900,
              ),
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                },
              ),
            ),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
              textTheme: GoogleFonts.poppinsTextTheme(),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.brown.shade900,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                  opacity: 0.8,
                  size: 25,
                ),
                titleTextStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                centerTitle: true,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey.shade100),
              )),
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                },
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: "Worden",
            home: FirebaseAuth.instance.currentUser == null
                ? const AuthPage()
                : const HomePage(),
          );
        });
  }
}
