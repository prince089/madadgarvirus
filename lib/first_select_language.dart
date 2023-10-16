import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madadgarvirus/authentication/register.dart';
import 'package:madadgarvirus/main.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  late String language = LanguagePreference.getLanguage() ?? 'en';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(str.chooseLanguage),
          backgroundColor: kDarkerColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RadioListTile(
                  title: const Text("English"),
                  value: "en",
                  groupValue: language,
                  onChanged: (value) async {
                    language = value.toString();
                    await LanguagePreference.setLanguage(value.toString());
                    selectedLanguage();
                  },
                ),
                RadioListTile(
                  title: const Text("हिंदी"),
                  value: "hi",
                  groupValue: language,
                  onChanged: (value) async {
                    language = value.toString();
                    await LanguagePreference.setLanguage(value.toString());
                    selectedLanguage();
                  },
                ),
                RadioListTile(
                  title: const Text("ગુજરાતી"),
                  value: "gu",
                  groupValue: language,
                  onChanged: (value) async {
                    language = value.toString();
                    await LanguagePreference.setLanguage(value.toString());
                    selectedLanguage();
                    // setState(() async {
                    //
                    //   // MyApp.setLocale(context,
                    //   //     Locale.fromSubtags(languageCode: value.toString()));
                    // });
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 6.0,
                        backgroundColor: kDarkColor,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              str.next,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: kLighterColor,
      ),
    );
  }

  void selectedLanguage() {
    setState(() {
      var changedLanguage = LanguagePreference.getLanguage();
      if (changedLanguage != null) {
        MyApp.of(context)
            ?.setLocale(Locale.fromSubtags(languageCode: changedLanguage));
      }
      // else {
      //   MyApp.setLocale(context, Locale.fromSubtags(languageCode: 'en'));
      // }
    });
  }
}
