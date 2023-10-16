import 'package:flutter/material.dart';
import 'package:madadgarvirus/main.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';

import 'language_preference.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String get preferenceLanguage => LanguagePreference.getLanguage() ?? 'en';
  late String setLanguage = preferenceLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(str.chooseLanguage),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: kDarkerColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            RadioListTile(
              title: const Text("English"),
              value: "en",
              groupValue: setLanguage,
              onChanged: (value) async {
                setLanguage = value.toString();
                await LanguagePreference.setLanguage(value.toString());
                changeLanguage();
              },
            ),
            RadioListTile(
              title: const Text("हिंदी"),
              value: "hi",
              groupValue: setLanguage,
              onChanged: (value) async {
                setLanguage = value.toString();
                await LanguagePreference.setLanguage(value.toString());
                changeLanguage();
              },
            ),
            RadioListTile(
              title: const Text("ગુજરાતી"),
              value: "gu",
              groupValue: setLanguage,
              onChanged: (value) async {
                setLanguage = value.toString();
                await LanguagePreference.setLanguage(value.toString());
                changeLanguage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void changeLanguage() {
    setState(() {
      var changedLanguage = LanguagePreference.getLanguage();
      if (changedLanguage != null) {
        if (MyApp.of(context) != null) {
          MyApp.of(context)!
              .setLocale(Locale.fromSubtags(languageCode: changedLanguage));
        }
      }
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    });
  }
}
