import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/new_job_model.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:madadgarvirus/utils/loading_widget.dart';
import 'package:madadgarvirus/utils/translator_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/dropDown/drop_down_helper.dart';
import '../../../utils/form_constants.dart';
import 'job_form_textfield.dart';

class NewJobFormScreen extends StatefulWidget {
  const NewJobFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewJobFormScreen> createState() => _NewJobFormScreenState();
}

class _NewJobFormScreenState extends State<NewJobFormScreen> {
  bool _healthInsuranceValue = true;
  bool _housingValue = true;
  bool isEditMode = true;
  bool isLoading = false;
  String loadingMsg = "";

  /// This is list of city which will pass to the drop down.
  /// This is job text field controllers.
  final TextEditingController _jobTextEditingController =
      TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _landfieldController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<DropDownItemModel> jobTypeList = kJobTypeList;
  List<DropDownItemModel> noOfPersonList = kNoOfPersonList;
  List<DropDownItemModel> salaryPreference = kSalaryPreferenceList;
  List<DropDownItemModel> selectedJobCategoryList = [];
  DropDownItemModel? _selectedJobType;
  DropDownItemModel? _noOfPerson;
  late DropDownItemModel selectedSalaryPreference = salaryPreference[1];

  //For Image picking
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedFiles = [];
  List<String>? uploadedImages;
  final _storageRef = FirebaseStorage.instance;
  var uploadItem = 0;
  JobModel? jobModel;

  @override
  void initState() {
    super.initState();
    getAndSetDetails();
  }

  Future<void> getAndSetDetails() async {
    final currentUser = await FirebaseRepository.instance.getCurrentUserData();
    jobModel = currentUser.job;
    if (jobModel != null) {
      isEditMode = false;
      if (jobModel!.selectedCategory != null) {
        final sCategory = jobModel!.selectedCategory!;
        for (final index in sCategory) {
          selectedJobCategoryList.add(kListOfJobs[index]);
        }
      }
      _selectedJobType =
          jobModel!.jobType != null ? jobTypeList[jobModel!.jobType!] : null;
      _noOfPerson = jobModel!.noOfPerson != null
          ? noOfPersonList[jobModel!.noOfPerson!]
          : null;
      selectedSalaryPreference =
          salaryPreference[jobModel!.salaryPreference ?? 1];
      _fromController.text = jobModel!.fromValue ?? "";
      _toController.text = jobModel!.toValue ?? "";

      _healthInsuranceValue = jobModel!.healthInsuranceValue;
      _housingValue = jobModel!.housingValue;

      final langCode = LanguagePreference.getLanguage();
      final jobInfoModel =
          jobModel!.getJobInfoModelFromCode(langCode: langCode);

      _jobTitleController.text = jobInfoModel.jobTitle ?? "";
      _descriptionController.text = jobInfoModel.jobDescription ?? "";
      _landfieldController.text = jobModel!.landfieldValue ?? "";
      uploadedImages = jobModel!.imageUrl;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(str.createNewJob),
        backgroundColor: kDarkerColor,
        actions: [
          if (jobModel != null) ...[
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
              onPressed: deleteJobInfo,
              icon: const Icon(Icons.delete),
            )
          ]
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
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
      child: AbsorbPointer(
        absorbing: !isEditMode,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              JobFormTextField(
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
              const SizedBox(
                height: 25.0,
              ),
              JobFormTextField(
                textEditingController: _jobTitleController,
                hint: str.jobTitle,
                isDropDown: false,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
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
                child: TextFormField(
                  controller: _landfieldController,
                  keyboardType: TextInputType.number,
                  //cursorColor: Colors.black,
                  onTap: () {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 8, bottom: 0, top: 0, right: 15),
                    hintText: str.howMuchLandYouHave,
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
                height: 25.0,
              ),
              Container(
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
                  child: DropdownButton2<DropDownItemModel>(
                    isExpanded: true,
                    hint: Text(
                      str.jobType,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: addDividersAfterItems(jobTypeList),
                    value: _selectedJobType,
                    onChanged: (value) {
                      _selectedJobType = value as DropDownItemModel;
                      setState(() {});
                    },
                    buttonStyleData: const ButtonStyleData(
                        height: 40, width: double.infinity),
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
              const SizedBox(
                height: 25.0,
              ),
              Container(
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
                      str.noOfPersons,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: addDividersAfterItems(noOfPersonList),
                    value: _noOfPerson,
                    onChanged: (value) {
                      _noOfPerson = value as DropDownItemModel;
                      setState(() {});
                    },
                    buttonStyleData: const ButtonStyleData(
                        height: 40, width: double.infinity),
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
              const SizedBox(
                height: 25.0,
              ),
              Container(
                width: double.infinity,
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
                      height: 15,
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
              const SizedBox(
                height: 25.0,
              ),
              Container(
                //color: Colors.black12,
                width: double.infinity,
                height: 100,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                //color: Colors.black12,
                width: double.infinity,
                height: 100,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      str.doOfferHousing,
                      style: const TextStyle(fontSize: 16),
                    ),
                    CupertinoSwitch(
                      activeColor: kDarkColor,
                      value: _housingValue,
                      onChanged: (value) {
                        setState(() {
                          _housingValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                height: 150,
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
              if (isEditMode) ...{
                const SizedBox(
                  height: 25.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    selectImage();
                  },
                  child: Text(str.selectImages),
                ),
              },

              const SizedBox(
                height: 25.0,
              ),
              if (uploadedImages != null && uploadedImages!.isNotEmpty) ...{
                GridView.builder(
                  itemCount: uploadedImages!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        uploadedImages![index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              } else if (_selectedFiles.isNotEmpty) ...{
                GridView.builder(
                  itemCount: _selectedFiles.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(_selectedFiles[index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              },
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.05,
                child: jobModel != null
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
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
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
        ),
      ),
    );
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
    if (_jobTitleController.text.isEmpty) {
      AnimatedSnackBar.material(
        str.notEmptyJobTitle,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (_landfieldController.text.isEmpty) {
      AnimatedSnackBar.material(
        str.notEmptyLandField,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (_selectedJobType == null) {
      showToast(_selectedJobType.toString());
      AnimatedSnackBar.material(
        str.notEmptyJobType,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (_noOfPerson == null) {
      AnimatedSnackBar.material(
        str.notEmptyNoOfPerson,
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
    if (_selectedFiles.isEmpty && uploadedImages == null) {
      AnimatedSnackBar.material(
        str.notEmptyImage,
        type: AnimatedSnackBarType.warning,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (_descriptionController.text.isEmpty) {
      _descriptionController.text = 'No Description Available';
    }

    List<String>? arrayImageUrl = uploadedImages;
    if (uploadedImages == null) {
      arrayImageUrl = await uploadFunction(_selectedFiles);
    }

    setState(() {
      isLoading = true;
      loadingMsg = "Posting Job";
    });
    List<String> listData = JobInfoModel(
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
    JobInfoModel engJobInfo = JobInfoModel.fromList(engListData);
    JobInfoModel gujJobInfo = JobInfoModel.fromList(gujListData);
    JobInfoModel hinJobInfo = JobInfoModel.fromList(hinListData);
    await FirebaseRepository.instance.uploadNewJobOfFarmer(
      JobModel(
        landfieldValue: _landfieldController.text,
        jobType: _selectedJobType!.value,
        noOfPerson: _noOfPerson!.value,
        salaryPreference: selectedSalaryPreference.value,
        fromValue: _fromController.text,
        toValue: _toController.text,
        healthInsuranceValue: _healthInsuranceValue,
        housingValue: _housingValue,
        imageUrl: arrayImageUrl!,
        selectedCategory: selectedJobCategoryList.map((e) => e.value).toList(),
        englishJobInfo: engJobInfo,
        hindiJobInfo: hinJobInfo,
        gujaratiJobInfo: gujJobInfo,
      ),
    );
    await getAndSetDetails();
    setState(() {
      isLoading = false;
      loadingMsg = "";
    });
    if (mounted) {
      await AnimatedSnackBar.material(
        str.thanksForPublishingJob,
        type: AnimatedSnackBarType.success,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
  }

  Future<List<String>> uploadFunction(List<XFile> images) async {
    setState(() {
      isLoading = true;
      loadingMsg = 'Uploading...$uploadItem/${_selectedFiles.length}';
    });
    final arrayImageUrl = <String>[];
    for (int i = 0; i < images.length; i++) {
      var imageUrl = await uploadFile(images[i]);
      arrayImageUrl.add(imageUrl.toString());
    }
    return arrayImageUrl;
  }

  Future<String> uploadFile(XFile image) async {
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final uid = await FirebaseRepository.instance.getCurrentUserId();
    Reference reference =
        _storageRef.ref().child('job_images/$uid/$uniqueFileName');
    UploadTask uploadTask = reference.putFile(File(image.path));
    try {
      await uploadTask;
      setState(() {
        uploadItem++;
        if (uploadItem == _selectedFiles.length) {
          isLoading = false;
          uploadItem = 0;
          showToast(str.imagesUploaded);
        }
      });
      return await reference.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }

  Future<void> selectImage() async {
    _selectedFiles.clear();
    uploadedImages = null;
    try {
      final List<XFile> imgs = await _picker.pickMultiImage();
      if (imgs.isNotEmpty && imgs.length < 4) {
        setState(() {
          _selectedFiles.addAll(imgs);
          showToast('${str.listOfSelectedImages} : ${imgs.length}');
        });
      } else {
        showToast(str.maxImagesAllowed);
      }
    } catch (e) {
      showToast('${str.somethingWrong} $e');
    }
  }

  void clearData() {
    jobModel = null;
    uploadedImages = null;
    selectedJobCategoryList = [];
    _jobTitleController.clear();
    _landfieldController.clear();
    _fromController.clear();
    _toController.clear();
    _descriptionController.clear();
    selectedSalaryPreference = salaryPreference[1];
    _healthInsuranceValue = true;
    _housingValue = true;
    _selectedJobType = null;
    _noOfPerson = null;
    _selectedFiles.clear();
  }

  Future<void> deleteJobInfo() async {
    setState(() {
      isLoading = true;
      loadingMsg = "Deleting Job";
    });
    await FirebaseRepository.instance.deleteJob();
    clearData();
    setState(() {
      isLoading = false;
      loadingMsg = "";
    });
  }
}
