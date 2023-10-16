import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/utils/extension.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/loading_widget.dart';
import '../../utils/translator_helper.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserModel? user;
  UserDataModel? userData;
  bool isLoading = false;
  bool _editProfile = false;
  String _imageUrl = '';
  String countryValue = '';
  String? stateValue = '';
  String? cityValue = '';
  XFile? file;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    setState(() {
      isLoading = true;
    });
    user = await FirebaseRepository.instance.getCurrentUserData();
    if (user != null) {
      final langCode = LanguagePreference.getLanguage();
      userData = user!.getUserDataModelFromCode(langCode: langCode);
      _editProfile = false;
      nameController.text = userData!.name;
      countryValue = userData?.country ?? '';
      stateValue = userData?.state ?? '';
      cityValue = userData?.city ?? '';
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(str.myAccount),
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: kDarkerColor,
      // ),
      body: AnimatedLoadingWidget(
        isLoading: isLoading,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: kDarkColor,
              expandedHeight: 200,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.radius30),
                      topRight: Radius.circular(context.radius30),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/GreenGradient.jpg',
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (user != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // child:
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                  image: user?.profileImage != null
                                      ? file != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                File(file!.path),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                user!.profileImage,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                      : null,
                                ),
                              ),
                              if (_editProfile)
                                Positioned(
                                  right: -4,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () async {
                                        ImagePicker imagePicker = ImagePicker();
                                        file = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        setState(() {});
                                      },
                                      child: SvgPicture.asset(
                                          "assets/Camera Icon.svg"),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(width: 24.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userData!.name} (${userData!.role})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                '${user!.age}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(18),
                        width: double.infinity,
                        //height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                str.personalInformation,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              const SizedBox(height: 24.0),
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        str.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: TextFormField(
                                          enabled: _editProfile,
                                          controller: nameController,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            height: 1.8,
                                          ),
                                          keyboardType: TextInputType.name,
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          validator: (value) {
                                            return null;

                                            //TODO: add validator
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        str.dob,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                        ),
                                        child: Text(
                                          user!.dob!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        str.phoneNO,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          '${user!.phone}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(18),
                        width: double.infinity,
                        //height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                str.address,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              const SizedBox(height: 24.0),
                              !_editProfile
                                  ? Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                          children: [
                                            Text(
                                              str.country,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.grey,
                                                height: 1.8,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                              ),
                                              child: Text(
                                                userData!.country!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              str.state,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.grey,
                                                height: 1.8,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child: Text(
                                                stateValue!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              str.city,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.grey,
                                                height: 1.8,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child: Text(
                                                cityValue!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : CSCPicker(
                                      disabledDropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                      layout: Layout.vertical,
                                      flagState: CountryFlag.DISABLE,
                                      defaultCountry: CscCountry.India,
                                      countryDropdownLabel:
                                          countryValue.isNotEmpty
                                              ? countryValue
                                              : "Country",
                                      stateDropdownLabel: stateValue != null &&
                                              stateValue!.isNotEmpty
                                          ? stateValue!
                                          : "State",
                                      cityDropdownLabel: cityValue != null &&
                                              cityValue!.isNotEmpty
                                          ? cityValue!
                                          : "City",
                                      disableCountry: true,
                                      onCountryChanged: (value) {
                                        setState(() {
                                          countryValue = value;
                                        });
                                      },
                                      onStateChanged: (value) {
                                        setState(() {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            stateValue = value;
                                          }
                                        });
                                      },
                                      onCityChanged: (value) {
                                        setState(() {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            cityValue = value;
                                          }
                                        });
                                      },
                                    ),
                              const SizedBox(width: 30.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _editProfile
                          ? SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await postDetailsToFirestore();
                                  _editProfile = false;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kDarkColor,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text(
                                  'str.save',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () {
                                  _editProfile = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kDarkColor,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text(
                                  'str.edit',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: isLoading
      //       ? const Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : user != null
      //           ? Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text("${str.name}: ${userData!.name}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.age}: ${user!.age}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.dob}: ${user!.dob}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.phone}: ${user!.phone}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.role}: ${userData!.role}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.city}: ${userData!.city}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.state}: ${userData!.state}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //                 Text("${str.country}: ${userData!.country}\n",
      //                     style: const TextStyle(fontSize: 18)),
      //               ],
      //             )
      //           : const Text("No user Data found"),
      // ),
      //backgroundColor: kLighterColor,
    );
  }

  Future<void> postDetailsToFirestore() async {
    setState(() {
      isLoading = true;
    });

    final name = nameController.text;
    List<String> listData = UserDataModel(
      name: name,
      city: cityValue,
      state: stateValue,
      country: user!.englishUserData.country,
      role: user!.englishUserData.role,
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

    UserDataModel engDataModel = UserDataModel.fromList(engListData);
    UserDataModel gujDataModel = UserDataModel.fromList(gujListData);
    UserDataModel hinDataModel = UserDataModel.fromList(hinListData);

    if (file != null) {
      Reference referenceImageToUpload =
          FirebaseStorage.instance.refFromURL(user!.profileImage);
      try {
        await referenceImageToUpload.putFile(File(file!.path));
        _imageUrl = await referenceImageToUpload.getDownloadURL();
        await updateProfilePicture(_imageUrl);
        setState(() {});
      } catch (error) {
        debugPrint(error.toString());
      }
    }

    await FirebaseRepository.instance.postUserDetailsToFirestore(
      user!.copyWith(
        englishUserData: engDataModel,
        gujaratiUserData: gujDataModel,
        hindiUserData: hinDataModel,
        profileImage: user!.profileImage,
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  updateProfilePicture(String imageUrl) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;

    CollectionReference ref = firebaseFirestore.collection('users');
    ref.doc(user!.uid).update({
      'profileimage': _imageUrl,
    });
  }
}
