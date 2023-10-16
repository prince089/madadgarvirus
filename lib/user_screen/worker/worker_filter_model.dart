import 'package:madadgarvirus/utils/dropDown/drop_down_helper.dart';

class WorkerFilterModel {
  WorkerFilterModel({
    this.city,
    this.state,
    this.fromSalary = 0,
    this.toSalary = 1000,
    this.fromLandField = 0,
    this.toLandField = 500,
    this.category,
    this.jobType,
    this.noOfPerson,
    this.healthInsurance = false,
    this.housingFacility = false,
  }) {
    category = [];
  }
  String? city;
  String? state;
  int fromSalary;
  int toSalary;
  int fromLandField;
  int toLandField;
  List<DropDownItemModel>? category;
  int? jobType;
  int? noOfPerson;
  bool healthInsurance;
  bool housingFacility;
}
