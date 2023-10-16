import 'package:madadgarvirus/user_screen/profile/language_preference.dart';

class RequestModel {
  RequestModel({
    required this.id,
    required this.profileImage,
    required this.nameEn,
    required this.nameHi,
    required this.nameGuj,
  });

  final String id;
  final String profileImage;
  final String nameEn;
  final String nameHi;
  final String nameGuj;

  String getName() {
    final langCode = LanguagePreference.getLanguage();
    switch (langCode) {
      case 'en':
        return nameEn;
      case 'gu':
        return nameGuj;
      case 'hi':
        return nameHi;
      default:
        return nameEn;
    }
  }

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      profileImage: json['profileImage'],
      nameEn: json['nameEn'],
      nameHi: json['nameHi'],
      nameGuj: json['nameGuj'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileImage': profileImage,
      'nameEn': nameEn,
      'nameHi': nameHi,
      'nameGuj': nameGuj,
    };
  }
}
