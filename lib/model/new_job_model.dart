import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  JobModel({
    this.landfieldValue,
    this.jobType,
    this.noOfPerson,
    this.salaryPreference,
    this.fromValue,
    this.toValue,
    this.healthInsuranceValue = true,
    this.housingValue = true,
    required this.imageUrl,
    this.docId,
    this.selectedCategory,
    required this.englishJobInfo,
    required this.gujaratiJobInfo,
    required this.hindiJobInfo,
  });

  final JobInfoModel englishJobInfo;
  final JobInfoModel gujaratiJobInfo;
  final JobInfoModel hindiJobInfo;

  final String? landfieldValue;
  final int? jobType;
  final int? noOfPerson;
  final int? salaryPreference;
  final String? fromValue;
  final String? toValue;
  final bool healthInsuranceValue;
  final bool housingValue;
  final List<String> imageUrl;
  String? docId;
  final List<int>? selectedCategory;

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      landfieldValue: json['landfield'],
      jobType: json['jobType'],
      noOfPerson: json['noOfPerson'],
      salaryPreference: json['salaryPreference'],
      fromValue: json['fromValue'],
      toValue: json['toValue'],
      healthInsuranceValue: json['healthInsurance'],
      housingValue: json['housing'],
      imageUrl: json['imageUrl'].cast<String>(),
      selectedCategory: json['selectedCategory'].cast<int>(),
      englishJobInfo: JobInfoModel.fromJson(json['en']),
      hindiJobInfo: JobInfoModel.fromJson(json['hi']),
      gujaratiJobInfo: JobInfoModel.fromJson(json['gu']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'landfield': landfieldValue,
      'jobType': jobType,
      'noOfPerson': noOfPerson,
      'salaryPreference': salaryPreference,
      'fromValue': fromValue,
      'toValue': toValue,
      'healthInsurance': healthInsuranceValue,
      'housing': housingValue,
      'imageUrl': FieldValue.arrayUnion(imageUrl),
      'selectedCategory': FieldValue.arrayUnion(selectedCategory ?? []),
      'en': englishJobInfo.toJson(),
      'hi': hindiJobInfo.toJson(),
      'gu': gujaratiJobInfo.toJson(),
    };
  }

  JobInfoModel getJobInfoModelFromCode({required String? langCode}) {
    switch (langCode) {
      case ('en'):
        return englishJobInfo;
      case ('gu'):
        return gujaratiJobInfo;
      case ('hi'):
        return hindiJobInfo;
      default:
        return englishJobInfo;
    }
  }

// bool get isFarmer => role == AppConstants.farmerRole;
// bool get isWorker => role == AppConstants.workerRole;
}

class JobInfoModel {
  JobInfoModel({
    this.jobTitle,
    this.jobDescription,
  });

  final String? jobTitle;
  final String? jobDescription;

  factory JobInfoModel.fromJson(Map<String, dynamic> json) {
    return JobInfoModel(
      jobTitle: json['jobTitle'],
      jobDescription: json['jobDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
    };
  }

  List<String> toList() => [
        jobTitle ?? '',
        jobDescription ?? '',
      ];

  factory JobInfoModel.fromList(List<String> list) => JobInfoModel(
        jobTitle: list[0],
        jobDescription: list[1],
      );
}
