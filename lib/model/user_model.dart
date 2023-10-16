import 'package:madadgarvirus/model/worker_details_model.dart';
import 'package:madadgarvirus/utils/app_constants.dart';

import 'new_job_model.dart';

class UserModel {
  UserModel({
    this.dob,
    this.phone,
    this.age,
    required this.profileImage,
    required this.englishUserData,
    required this.gujaratiUserData,
    required this.hindiUserData,
    this.docId,
    this.job,
    this.moreDetail,
  });

  final String? dob;
  final double? age;
  final String? phone;

  final String profileImage;
  final UserDataModel englishUserData;
  final UserDataModel gujaratiUserData;
  final UserDataModel hindiUserData;
  final JobModel? job;
  final WorkerDetailsModel? moreDetail;
  String? docId;

  UserModel copyWith({
    String? profileImage,
    UserDataModel? englishUserData,
    UserDataModel? gujaratiUserData,
    UserDataModel? hindiUserData,
  }) =>
      UserModel(
        dob: dob,
        age: age,
        phone: phone,
        docId: docId,
        job: job,
        moreDetail: moreDetail,
        profileImage: profileImage ?? this.profileImage,
        gujaratiUserData: gujaratiUserData ?? this.gujaratiUserData,
        hindiUserData: hindiUserData ?? this.hindiUserData,
        englishUserData: englishUserData ?? this.englishUserData,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      dob: json['dob'],
      age: json['age'],
      phone: json['phone'],
      profileImage: json['profileimage'],
      docId: json['docId'],
      englishUserData: UserDataModel.fromJson(json['en']),
      gujaratiUserData: UserDataModel.fromJson(json['gu']),
      hindiUserData: UserDataModel.fromJson(json['hi']),
      job: json['job'] != null ? JobModel.fromJson(json['job']) : null,
      moreDetail: json['more_details'] != null
          ? WorkerDetailsModel.fromJson(json['more_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dob': dob,
      'age': age,
      'phone': phone,
      'profileimage': profileImage,
      'docId': docId,
      'en': englishUserData.toJson(),
      'gu': gujaratiUserData.toJson(),
      'hi': hindiUserData.toJson(),
      'job': job?.toJson(),
      'more_details': moreDetail?.toJson(),
    };
  }

  bool get isFarmer => englishUserData.role == AppConstants.farmerRole;

  bool get isWorker => englishUserData.role == AppConstants.workerRole;

  UserDataModel getUserDataModelFromCode({required String? langCode}) {
    switch (langCode) {
      case ('en'):
        return englishUserData;
      case ('gu'):
        return gujaratiUserData;
      case ('hi'):
        return hindiUserData;
      default:
        return englishUserData;
    }
  }
}

class UserDataModel {
  UserDataModel({
    required this.name,
    this.city,
    this.country,
    this.state,
    this.role,
  });

  String name;
  String? city;
  String? country;
  String? state;
  String? role;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json['name'],
      city: json['city'],
      country: json['country'],
      state: json['state'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'city': city,
      'country': country,
      'state': state,
      'role': role,
    };
  }

  List<String> toList() => [
        name,
        role ?? '',
        city ?? '',
        state ?? '',
        country ?? '',
      ];

  factory UserDataModel.fromList(List<String> list) => UserDataModel(
        name: list[0],
        role: list[1],
        city: list[2],
        state: list[3],
        country: list[4],
      );
}
