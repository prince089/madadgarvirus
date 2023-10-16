import 'package:cloud_firestore/cloud_firestore.dart';

class WorkerDetailsModel {
  WorkerDetailsModel({
    this.selectedEducationValue,
    this.jobType,
    this.noOfPerson,
    this.workExperienceValue,
    this.isEmployed = false,
    this.salaryPreference,
    this.fromValue,
    this.toValue,
    this.currentWage,
    this.healthInsuranceValue = true,
    this.drivingLicenseValue = true,
    this.housingValue = true,
    this.docId,
    this.selectedCategory,
    required this.englishJobInfo,
    required this.gujaratiJobInfo,
    required this.hindiJobInfo,
  });

  final WorkerJobInfoModel englishJobInfo;
  final WorkerJobInfoModel gujaratiJobInfo;
  final WorkerJobInfoModel hindiJobInfo;

  final int? selectedEducationValue;
  final int? jobType;
  final int? noOfPerson;
  final int? workExperienceValue;
  final bool isEmployed;
  final int? salaryPreference;
  final String? fromValue;
  final String? toValue;
  final String? currentWage;
  final bool healthInsuranceValue;
  final bool drivingLicenseValue;
  final bool housingValue;
  String? docId;
  final List<int>? selectedCategory;

  factory WorkerDetailsModel.fromJson(Map<String, dynamic> json) {
    return WorkerDetailsModel(
      selectedEducationValue: json['education'],
      jobType: json['jobType'],
      noOfPerson: json['noOfPerson'],
      workExperienceValue: json['workExperience'],
      isEmployed: json['isEmployed'],
      salaryPreference: json['salaryPreference'],
      fromValue: json['fromValue'],
      toValue: json['toValue'],
      currentWage: json['currentWage'],
      healthInsuranceValue: json['healthInsurance'],
      drivingLicenseValue: json['drivingLicense'],
      housingValue: json['housing'],
      selectedCategory: json['selectedCategory'].cast<int>(),
      englishJobInfo: WorkerJobInfoModel.fromJson(json['en']),
      hindiJobInfo: WorkerJobInfoModel.fromJson(json['hi']),
      gujaratiJobInfo: WorkerJobInfoModel.fromJson(json['gu']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'education': selectedEducationValue,
      'jobType': jobType,
      'noOfPerson': noOfPerson,
      'workExperience': workExperienceValue,
      'isEmployed': isEmployed,
      'salaryPreference': salaryPreference,
      'fromValue': fromValue,
      'toValue': toValue,
      'currentWage': currentWage,
      'healthInsurance': healthInsuranceValue,
      'drivingLicense': drivingLicenseValue,
      'housing': housingValue,
      'selectedCategory': FieldValue.arrayUnion(selectedCategory ?? []),
      'en': englishJobInfo.toJson(),
      'hi': hindiJobInfo.toJson(),
      'gu': gujaratiJobInfo.toJson(),
    };
  }

  WorkerJobInfoModel getJobInfoModelFromCode({required String? langCode}) {
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

class WorkerJobInfoModel {
  WorkerJobInfoModel({
    this.atWhereEmployed,
    this.jobTitle,
    this.jobDescription,
  });

  final String? atWhereEmployed;
  final String? jobTitle;
  final String? jobDescription;

  factory WorkerJobInfoModel.fromJson(Map<String, dynamic> json) {
    return WorkerJobInfoModel(
      atWhereEmployed: json['atWhereEmployed'],
      jobTitle: json['jobTitle'],
      jobDescription: json['jobDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'atWhereEmployed': atWhereEmployed,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
    };
  }

  List<String> toList() => [
        atWhereEmployed ?? '',
        jobTitle ?? '',
        jobDescription ?? '',
      ];

  factory WorkerJobInfoModel.fromList(List<String> list) => WorkerJobInfoModel(
        atWhereEmployed: list[0],
        jobTitle: list[1],
        jobDescription: list[2],
      );
}
