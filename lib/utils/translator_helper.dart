import 'package:translator/translator.dart';

class TranslatorHelper {
  TranslatorHelper._();

  static TranslatorHelper instance = TranslatorHelper._();

  GoogleTranslator translator = GoogleTranslator();

  Future<String> fromString({
    required String text,
    required String code,
  }) async {
    Translation translation =
        await translator.translate(text.toString(), to: code);
    return translation.text;
  }

  Future<List<String>> fromList({
    required List<String> data,
    required String code,
  }) async {
    final translatedData = <String>[];
    for (var text in data) {
      final data = await fromString(
        text: text,
        code: code,
      );
      translatedData.add(data);
    }
    return translatedData;
  }
}
