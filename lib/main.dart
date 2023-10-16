import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madadgarvirus/app_config.dart';
import 'package:madadgarvirus/user_screen/dashboard/home_screen.dart';
import 'package:madadgarvirus/user_screen/farmer/farmer_home.dart';
import 'package:madadgarvirus/user_screen/profile/change_language.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'authentication/login.dart';
import 'authentication/otp.dart';
import 'authentication/register.dart';
import 'first_select_language.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TextToSpeech.initTTS();
  await Firebase.initializeApp();
  await LanguagePreference.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static get preferenceLanguage => LanguagePreference.getLanguage() ?? 'en';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Locale _locale = Locale.fromSubtags(languageCode: preferenceLanguage);
  //countryCode: 'US'
  void setLocale(Locale newLocale) async {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //check for errors
        if (snapshot.hasError) {
          debugPrint('something went wrong');
        }
        //once completed, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            localizationsDelegates: const [
              // 1
              S.delegate,
              // 2
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: _locale,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const AppConfig(),
              'register': (context) => const Register(),
              'login': (context) => const LoginPage(),
              // 'otp': (context) => const MyOtp(
              //       verificationId: 'dkdgdg',
              //     ),
              'home_screen': (context) => const HomeScreen(),
              'farmer_home': (context) => const FarmerHome(),
              'changeLanguage': (context) => const ChangeLanguage(),
              'first_select_language': (context) => const SelectLanguage(),
              //'requests': (context) => const DropDownListExample(),
              // 'profile_screen': (context) => const ProfileScreen(),
              //'resource_page': (context) => const ResourcePage(),
            },
            theme: ThemeData(
              primaryColor: Colors.blue[900],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
