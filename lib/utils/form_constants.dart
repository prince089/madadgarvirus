// Constant Messages

// App Title
//const kTitle = 'DropDownList';

import 'dropDown/drop_down_helper.dart';
// Cities
import 'helper.dart';

List<DropDownItemModel> get kListOfJobs => [
  DropDownItemModel(name: str.harvesting, value: 0),
  DropDownItemModel(name: str.mechanic, value: 1),
  DropDownItemModel(name: str.planting, value: 2),
  DropDownItemModel(name: str.truckDriver, value: 3),
  DropDownItemModel(name: str.cowBoy, value: 4),
  DropDownItemModel(name: str.generalFarmWork, value: 5),
  DropDownItemModel(name: str.waterManagement, value: 6),
  DropDownItemModel(name: str.cropCare, value: 7),
  DropDownItemModel(name: str.dirtOrRockRemoval, value: 8),
  DropDownItemModel(name: str.machineryUpkeep, value: 9),
  DropDownItemModel(name: str.tilling, value: 10),
];

 List<DropDownItemModel> get kJobTypeList => <DropDownItemModel>[
  DropDownItemModel(name: str.fullTime, value: 0),
  DropDownItemModel(name: str.partTime, value: 1),
  DropDownItemModel(name: str.seasonal, value: 2),
  DropDownItemModel(name: str.oneTimeJob, value: 3),
];

 List<DropDownItemModel> get kNoOfPersonList => [
  DropDownItemModel(name: str.one, value: 0),
  DropDownItemModel(name: str.two, value: 1),
  DropDownItemModel(name: str.three, value: 2),
  DropDownItemModel(name: str.moreThan5, value: 3),
  DropDownItemModel(name: str.moreThan10, value: 4),
  DropDownItemModel(name: str.moreThan15, value: 5),
  DropDownItemModel(name: str.moreThan20, value: 6),
];

 List<DropDownItemModel> get kEducationDetailList => [
  DropDownItemModel(name: str.associatesOfScience, value: 0),
  DropDownItemModel(name: str.bachelors, value: 1),
  DropDownItemModel(name: str.highSchoolDiploma, value: 2),
  DropDownItemModel(name: str.masters, value: 3),
  DropDownItemModel(name: str.someCollege, value: 4),
  DropDownItemModel(name: str.stillInHighSchool, value: 5),
  DropDownItemModel(name: str.tradeSchool, value: 6),
  DropDownItemModel(name: str.notEducated, value: 7),
  DropDownItemModel(name: str.other, value: 8),
];

 List<DropDownItemModel> get kWorkExperienceList => [
  DropDownItemModel(name: str.zero, value: 0),
  DropDownItemModel(name: str.one, value: 1),
  DropDownItemModel(name: str.two, value: 2),
  DropDownItemModel(name: str.three, value: 3),
  DropDownItemModel(name: str.moreThan5, value: 4),
  DropDownItemModel(name: str.moreThan10, value: 5),
  DropDownItemModel(name: str.moreThan15, value: 6),
  DropDownItemModel(name: str.moreThan20, value: 7),
];

 List<DropDownItemModel> get kSalaryPreferenceList => [
  DropDownItemModel(name: str.hourlyRate, value: 0),
  DropDownItemModel(name: str.fixedSalary, value: 1),
  DropDownItemModel(name: str.perAcre, value: 2),
];
