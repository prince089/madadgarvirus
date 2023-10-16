import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/utils/dropDown/drop_down_helper.dart';
import 'package:madadgarvirus/utils/form_constants.dart';
import 'package:madadgarvirus/utils/loading_widget.dart';

import '../../../firebase_repository.dart';
import '../../../model/worker_details_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/translator_helper.dart';
import '../../farmer/create_new_job/job_form_textfield.dart';

class AddMoreDetails extends StatefulWidget {
  const AddMoreDetails({Key? key}) : super(key: key);

  @override
  State<AddMoreDetails> createState() => _AddMoreDetailsState();
}

class _AddMoreDetailsState extends State<AddMoreDetails> {
  bool _healthInsuranceValue = true;
  bool _housingValue = true;
  bool _drivingLicenseValue = true;
  bool isEditMode = true;
  bool isLoading = false;
  String loadingMsg = "";

  List<DropDownItemModel> educationList = kEducationDetailList;
  List<DropDownItemModel> interestedForList = kJobTypeList;
  List<DropDownItemModel> noOfPersonList = kNoOfPersonList;
  List<DropDownItemModel> workExperienceList = kWorkExperienceList;
  List<DropDownItemModel> salaryPreference = kSalaryPreferenceList;

  List<DropDownItemModel> selectedJobCategoryList = [];
  DropDownItemModel? selectedEducation;
  DropDownItemModel? selectedInterestedFor;
  DropDownItemModel? noOfPerson;
  DropDownItemModel? workExperience;

  /// This is job text field controllers.
  final TextEditingController _jobTextEditingController =
      TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _whereController = TextEditingController();
  final TextEditingController _wageController = TextEditingController();
  late DropDownItemModel selectedSalaryPreference = salaryPreference[1];
  bool currentlyEmployed = false;
  WorkerDetailsModel? workerDetailsModel;

  @override
  void initState() {
    super.initState();
    getAndSetDetails();
  }

  Future<void> getAndSetDetails() async {
    final currentUser = await FirebaseRepository.instance.getCurrentUserData();
    workerDetailsModel = currentUser.moreDetail;
    if (workerDetailsModel != null) {
      isEditMode = false;
      if (workerDetailsModel!.selectedCategory != null) {
        final sCategory = workerDetailsModel!.selectedCategory!;
        for (final index in sCategory) {
          selectedJobCategoryList.add(kListOfJobs[index]);
        }
      }
      selectedEducation = workerDetailsModel!.selectedEducationValue != null
          ? educationList[workerDetailsModel!.selectedEducationValue!]
          : null;
      selectedInterestedFor = workerDetailsModel!.jobType != null
          ? interestedForList[workerDetailsModel!.jobType!]
          : null;
      noOfPerson = workerDetailsModel!.noOfPerson != null
          ? noOfPersonList[workerDetailsModel!.noOfPerson!]
          : null;
      workExperience = workerDetailsModel!.workExperienceValue != null
          ? workExperienceList[workerDetailsModel!.workExperienceValue!]
          : null;
      currentlyEmployed = workerDetailsModel!.isEmployed;
      _wageController.text = workerDetailsModel!.currentWage ?? "";
      selectedSalaryPreference =
          salaryPreference[workerDetailsModel!.salaryPreference ?? 1];
      _fromController.text = workerDetailsModel!.fromValue ?? "";
      _toController.text = workerDetailsModel!.toValue ?? "";

      _healthInsuranceValue = workerDetailsModel!.healthInsuranceValue;
      _housingValue = workerDetailsModel!.housingValue;
      _drivingLicenseValue = workerDetailsModel!.drivingLicenseValue;

      final langCode = LanguagePreference.getLanguage();
      final jobInfoModel =
          workerDetailsModel!.getJobInfoModelFromCode(langCode: langCode);

      _whereController.text = jobInfoModel.atWhereEmployed ?? "";
      _jobTitleController.text = jobInfoModel.jobTitle ?? "";
      _descriptionController.text = jobInfoModel.jobDescription ?? "";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(str.addMoreDetails),
          backgroundColor: kDarkerColor,
          actions: [
            if (workerDetailsModel != null) ...[
              IconButton(
                onPressed: () {
                  setState(() {
                    isEditMode = !isEditMode;
                    showToast(
                      "Editing mode ${isEditMode ? "enabled" : "disabled"}",
                    );
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: isEditMode ? Colors.grey : null,
                ),
              ),
              IconButton(
                onPressed: deleteMoreDetail,
                icon: const Icon(Icons.delete),
              )
            ]
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: AnimatedLoadingWidget(
            isLoading: isLoading,
            loadingMsg: loadingMsg,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _mainBody(),
            ),
          ),
        ),
      ),
    );
  }

  /// This is Main Body widget.
  Widget _mainBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: JobFormTextField(
              textEditingController: _jobTextEditingController,
              hint: selectedJobCategoryList.isEmpty
                  ? str.chooseCategories
                  : selectedJobCategoryList
                      .map((e) => e.name)
                      .toList()
                      .join(', '),
              isDropDown: true,
              jobs: kListOfJobs,
              onDone: (selectedCategory) {
                selectedJobCategoryList = selectedCategory;
                setState(() {});
              },
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    str.education,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: addDividersAfterItems(educationList),
                  value: selectedEducation,
                  onChanged: (value) {
                    setState(() {
                      selectedEducation = value as DropDownItemModel;
                    });
                  },
                  buttonStyleData:
                      const ButtonStyleData(height: 40, width: double.infinity),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(),
                    maxHeight: 250,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    customHeights: getCustomItemsHeightsForEducation(),
                  ),
                  barrierColor: Colors.black12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    str.intrestedFor,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: addDividersAfterItems(interestedForList),
                  value: selectedInterestedFor,
                  onChanged: (value) {
                    setState(() {
                      selectedInterestedFor = value as DropDownItemModel;
                    });
                  },
                  buttonStyleData:
                      const ButtonStyleData(height: 40, width: double.infinity),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(),
                    maxHeight: 200,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    customHeights: getCustomItemsHeights(),
                  ),
                  barrierColor: Colors.black12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    str.weArePersons,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: addDividersAfterItems(noOfPersonList),
                  value: noOfPerson,
                  onChanged: (value) {
                    setState(() {
                      noOfPerson = value as DropDownItemModel;
                    });
                  },
                  buttonStyleData:
                      const ButtonStyleData(height: 40, width: double.infinity),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(),
                    maxHeight: 250,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    customHeights: getCustomItemsHeightsForPersonList(),
                  ),
                  barrierColor: Colors.black12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    str.workExperience,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: addDividersAfterItems(workExperienceList),
                  value: workExperience,
                  onChanged: (value) {
                    setState(() {
                      workExperience = value as DropDownItemModel;
                    });
                  },
                  buttonStyleData:
                      const ButtonStyleData(height: 40, width: double.infinity),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(),
                    maxHeight: 150,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    customHeights: getCustomItemsHeightsForWorkExperience(),
                  ),
                  barrierColor: Colors.black12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              //color: Colors.black12,
              width: double.infinity,
              //height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    str.areYouEmployed,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text(str.yes),
                          value: true,
                          groupValue: currentlyEmployed,
                          onChanged: (value) {
                            currentlyEmployed = true;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text(str.no),
                          value: false,
                          groupValue: currentlyEmployed,
                          onChanged: (value) {
                            currentlyEmployed = false;
                            _whereController.clear();
                            _wageController.clear();
                            _jobTitleController.clear();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (currentlyEmployed) ...{
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _whereController,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        onTap: () {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          // contentPadding: EdgeInsets.only(
                          //     left: 8, bottom: 0, top: 0, right: 15),
                          hintText: str.where,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          return null;

                          //TODO: add validator
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _wageController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        onTap: () {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          // contentPadding: EdgeInsets.only(
                          //     left: 8, bottom: 0, top: 0, right: 15),
                          hintText: str.currentWage,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          return null;

                          //TODO: add validator
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _jobTitleController,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        onTap: () {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          // contentPadding: EdgeInsets.only(
                          //     left: 8, bottom: 0, top: 0, right: 15),
                          hintText: str.currentJobTitle,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          return null;

                          //TODO: add validator
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  }
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              //color: Colors.black12,
              width: double.infinity,
              //height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    str.preferToPaid,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ...salaryPreference
                      .map(
                        (e) => RadioListTile(
                          title: Text(e.name),
                          value: e,
                          groupValue: selectedSalaryPreference,
                          onChanged: (value) {
                            selectedSalaryPreference = e;
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 8, bottom: 16, left: 16),
                          child: TextFormField(
                            controller: _fromController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            onTap: () {},
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              // contentPadding: EdgeInsets.only(
                              //     left: 8, bottom: 0, top: 0, right: 15),
                              hintText: '${str.from} (₹)',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            validator: (value) {
                              return null;

                              //TODO: add validator
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, bottom: 16, left: 8),
                          child: TextFormField(
                            controller: _toController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            onTap: () {},
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              // contentPadding: EdgeInsets.only(
                              //     left: 8, bottom: 0, top: 0, right: 15),
                              hintText: '${str.to} (₹)',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            validator: (value) {
                              return null;

                              //TODO: add validator
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              //color: Colors.black12,
              width: double.infinity,
              //height: 100,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    str.doOfferHealthInsurance,
                    style: const TextStyle(fontSize: 16),
                  ),
                  CupertinoSwitch(
                    activeColor: kDarkColor,
                    value: _healthInsuranceValue,
                    onChanged: (value) {
                      setState(() {
                        _healthInsuranceValue = value;
                        showToast(_healthInsuranceValue.toString());
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              //color: Colors.black12,
              width: double.infinity,
              //height: 100,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    str.haveDrivingLicense,
                    style: const TextStyle(fontSize: 16),
                  ),
                  CupertinoSwitch(
                    activeColor: kDarkColor,
                    value: _drivingLicenseValue,
                    onChanged: (value) {
                      setState(() {
                        _drivingLicenseValue = value;
                        showToast(_drivingLicenseValue.toString());
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              //color: Colors.black12,
              width: double.infinity,
              //height: 100,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      str.lookingForHousing,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CupertinoSwitch(
                    activeColor: kDarkColor,
                    value: _housingValue,
                    onChanged: (value) {
                      setState(() {
                        _housingValue = value;
                        showToast(_housingValue.toString());
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          AbsorbPointer(
            absorbing: !isEditMode,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              //height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                maxLines: 4,
                maxLength: 150,
                controller: _descriptionController,
                keyboardType: TextInputType.name,
                //cursorColor: Colors.black,
                onTap: () {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(
                      left: 8, bottom: 0, top: 20, right: 15),
                  hintText: str.jobDescription,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                validator: (value) {
                  return null;

                  //TODO: add validator
                },
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.05,
            child: workerDetailsModel != null
                ? isEditMode
                    ? ElevatedButton(
                        onPressed: () async => onPublishJob(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkColor,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        child: Text(
                          str.editJob,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.normal),
                        ))
                    : const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () async => onPublishJob(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkColor,
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text(
                      str.publishJob,
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                    ),
                  ),
          ),
          // _AppElevatedButton(),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }

  void clearData() {
    workerDetailsModel = null;
    selectedJobCategoryList = [];
    _fromController.clear();
    _toController.clear();
    _descriptionController.clear();
    selectedSalaryPreference = salaryPreference[1];
    _healthInsuranceValue = true;
    _housingValue = true;
    selectedEducation = null;
    workExperience = null;
    noOfPerson = null;
    selectedInterestedFor = null;
    _whereController.clear();
    _wageController.clear();
    _jobTitleController.clear();
  }

  Future<void> onPublishJob() async {
    if (selectedJobCategoryList.isEmpty) {
      AnimatedSnackBar.material(
        str.notEmptyJobCategory,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (selectedEducation == null) {
      AnimatedSnackBar.material(
        str.notEmptyEducation,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (selectedInterestedFor == null) {
      AnimatedSnackBar.material(
        str.notEmptyJobType,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (noOfPerson == null) {
      AnimatedSnackBar.material(
        str.notEmptyNoOfPerson,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (workExperience == null) {
      AnimatedSnackBar.material(
        str.notEmptyWorkExperience,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      AnimatedSnackBar.material(
        str.notEmptyFromTo,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (currentlyEmployed) {
      if (_whereController.text.isEmpty) {
        AnimatedSnackBar.material(
          str.notEmptyWhereEmployed,
          type: AnimatedSnackBarType.error,
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
        ).show(context);
        return;
      }
      if (_wageController.text.isEmpty) {
        AnimatedSnackBar.material(
          str.currentWage,
          type: AnimatedSnackBarType.error,
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
        ).show(context);
        return;
      }
      if (_jobTitleController.text.isEmpty) {
        AnimatedSnackBar.material(
          str.notEmptyJobTitle,
          type: AnimatedSnackBarType.error,
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
        ).show(context);
        return;
      }
    } else {
      _whereController.text = 'No where (Not employed)';
      _jobTitleController.text = 'No title (Not employed)';
      _wageController.text = '0';
    }
    if (_descriptionController.text.isEmpty) {
      _descriptionController.text = 'No Description Available';
    }
    setState(() {
      isLoading = true;
      loadingMsg = "Posting More details";
    });
    List<String> listData = WorkerJobInfoModel(
      atWhereEmployed: _whereController.text,
      jobTitle: _jobTitleController.text,
      jobDescription: _descriptionController.text,
    ).toList();

    List<String> engListData = await TranslatorHelper.instance.fromList(
      data: listData,
      code: 'en',
    );
    List<String> gujListData = await TranslatorHelper.instance.fromList(
      data: listData,
      code: 'gu',
    );
    List<String> hinListData = await TranslatorHelper.instance.fromList(
      data: listData,
      code: 'hi',
    );
    WorkerJobInfoModel engJobInfo = WorkerJobInfoModel.fromList(engListData);
    WorkerJobInfoModel gujJobInfo = WorkerJobInfoModel.fromList(gujListData);
    WorkerJobInfoModel hinJobInfo = WorkerJobInfoModel.fromList(hinListData);
    await FirebaseRepository.instance.uploadMoreDetailsOfWorker(
      WorkerDetailsModel(
        selectedEducationValue: selectedEducation!.value,
        jobType: selectedInterestedFor!.value,
        noOfPerson: noOfPerson!.value,
        workExperienceValue: workExperience!.value,
        salaryPreference: selectedSalaryPreference.value,
        fromValue: _fromController.text,
        toValue: _toController.text,
        currentWage: _wageController.text,
        healthInsuranceValue: _healthInsuranceValue,
        drivingLicenseValue: _drivingLicenseValue,
        housingValue: _housingValue,
        selectedCategory: selectedJobCategoryList
            .map(
              (e) => e.value,
            )
            .toList(),
        isEmployed: currentlyEmployed,
        englishJobInfo: engJobInfo,
        hindiJobInfo: hinJobInfo,
        gujaratiJobInfo: gujJobInfo,
      ),
    );
    if (mounted) {
      await AnimatedSnackBar.material(
        str.thanksForPublishingJob,
        type: AnimatedSnackBarType.success,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
    await getAndSetDetails();
    setState(() {
      isLoading = false;
      loadingMsg = "";
    });
  }

  Future<void> deleteMoreDetail() async {
    setState(() {
      isLoading = true;
      loadingMsg = "Deleting more details";
    });
    await FirebaseRepository.instance.deleteMoreDetail();
    clearData();
    setState(() {
      isLoading = false;
      loadingMsg = "";
    });
  }
}
