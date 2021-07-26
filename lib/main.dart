// Basic imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';

// Routes
import 'package:ug_mini_market/screens/login.dart';
import 'package:ug_mini_market/screens/main_screen.dart';
import 'package:ug_mini_market/screens/warning_screen.dart';

// Backend
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UG Market',
      theme: ThemeData(
        primaryColor: const Color(0xFFff7d95),
        primaryColorLight: const Color(0xFFffafc5),
        primaryColorDark: const Color(0xFFc84c67),
        accentColor: const Color(0xFF7D95FF),
        scaffoldBackgroundColor: const Color(0xFFfff3e6),
        primarySwatch: createMaterialColor(Color(0xFFc84c67)),
        textTheme: TextTheme(
          headline1: GoogleFonts.workSans(
              textStyle: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
          headline2: GoogleFonts.workSans(
              textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          )),
          headline3: GoogleFonts.workSans(
              textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
          headline4: GoogleFonts.workSans(
              textStyle: const TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
          headline5: GoogleFonts.workSans(
              textStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          )),
          headline6: GoogleFonts.workSans(
              textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
          subtitle1: GoogleFonts.lato(
              textStyle: const TextStyle(
            fontSize: 18,
          )),
          subtitle2: GoogleFonts.lato(
              textStyle: const TextStyle(
            fontSize: 20,
            color: const Color(0xCCFFFFFF),
            fontWeight: FontWeight.bold,
          )),
          bodyText1: GoogleFonts.lato(
              textStyle: const TextStyle(
            fontSize: 18,
          )),
          bodyText2: GoogleFonts.lato(
              textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          )),
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context).textTheme.headline2,
          titleSpacing: 1,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF4668cb),
          hoverColor: const Color(0xFF7d95ff),
          splashColor: const Color(0xFFb2c5ff),
          disabledColor: const Color(0xFF828282),
          textTheme: ButtonTextTheme.primary,
          minWidth: 50,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF4668cb),
          hoverColor: const Color(0xFF7d95ff),
          splashColor: const Color(0xFFb2c5ff),
          elevation: 10,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF4668cb),
            shadowColor: const Color(0xFF7d95ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPrimary: Colors.white.withOpacity(0.75),
            textStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            color: Color(0xFFde0b0b),
          )),
          labelStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          )),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).primaryColorDark, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFde0b0b), width: 0.0),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFa30000), width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: Theme.of(context).textTheme.headline3,
          contentTextStyle: Theme.of(context).textTheme.bodyText1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          elevation: 5,
        ),
        dividerTheme: DividerThemeData(
            color: Colors.grey.withOpacity(0.5), thickness: 1, space: 10),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Color(0xFF3d0086);
              }
              return Colors.grey.shade300;
            },
          ),
          thumbColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Color(0xFFa647ea);
              }
              return Colors.white;
            },
          ),
        ),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //----- ROUTES -----
      initialRoute: '/',
      routes: {
        '/': (context) => WarningScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings);
        switch (settings.name) {
          case '/login':
            return PageTransition(
              child: LoginScreen(),
              type: PageTransitionType.leftToRight,
              curve: Curves.easeIn,
            );
          case '/signup':
            return PageTransition(
              child: SignUpScreen(),
              type: PageTransitionType.leftToRight,
              curve: Curves.easeIn,
            );
          case '/recover':
            return PageTransition(
              child: RecoverPasswordScreen(),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
            );
          case '/mainscreen':
            final user = settings.arguments as UGUser;
            return PageTransition(
              child: MainScreen(
                user: user,
              ),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
            );
          default:
            assert(false, 'Need to implement ${settings.name}');
            return null;
        }
      },
    );
  }
}
