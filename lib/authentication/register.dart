import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/user_model.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

import '../utils/translator_helper.dart';
import 'login.dart';
import 'otp.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showProgress = false;
  bool visible = false;
  var countryCode = "+91";
  var age = "";
  double difference = 0.0;
  double roundedDifference = 0.0;

  GoogleTranslator translator = GoogleTranslator();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final options = [
    str.worker,
    str.farmer,
  ];
  var selectedRole = str.farmer;

  String countryValue = '';
  String? stateValue = '';
  String? cityValue = '';
  String _imageUrl = '';

  // from here
  File? _image;
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _uploadImageToFirebase() async {
    setState(() {
      _isUploading = true;
    });
    final storage = FirebaseStorage.instance;
    //final fileName = 'avatar.jpg';
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = storage.ref().child('profileImages/$uniqueFileName');
    if (_image != null) {
      final task = ref.putFile(_image!);
      try {
        await task;
        _imageUrl = await ref.getDownloadURL();

        setState(() {
          _isUploading = false;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: kDarkColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.all(18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          str.register,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //TODO: image is uploaded even we didn't register.
                        InkWell(
                          onTap: () => _pickImage(ImageSource.gallery),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _isUploading
                                ? const CircularProgressIndicator()
                                : _image == null
                                    ? const Center(
                                        child: CircleAvatar(
                                          backgroundColor: kDarkColor,
                                          radius: 45,
                                          backgroundImage: AssetImage(
                                              'assets/profileavtar.png'),
                                        ),
                                      )
                                    : null,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Register as :',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            DropdownButton<String>(
                              dropdownColor:
                                  const Color.fromRGBO(78, 148, 79, 1),
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Colors.white,
                              focusColor: Colors.white,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  selectedRole = newValueSelected!;
                                });
                              },
                              value: selectedRole,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Name
                        //
                        TextFormField(
                          maxLength: 25,
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person_rounded,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: str.name,
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLength: 10,
                          buildCounter: (
                            context, {
                            required int currentLength,
                            required bool isFocused,
                            required int? maxLength,
                          }) =>
                              const SizedBox.shrink(),
                          controller: phoneController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: str.phoneNO,
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CSCPicker(
                          disabledDropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          layout: Layout.horizontal,
                          flagState: CountryFlag.DISABLE,
                          defaultCountry: CscCountry.India,
                          disableCountry: true,
                          onCountryChanged: (value) {
                            setState(() {
                              countryValue = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              stateValue = value;
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              cityValue = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //Date picker
                        TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today_rounded,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: str.date,
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          // decoration: const InputDecoration(
                          //     icon: Icon(Icons.calendar_today), labelText: ""),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1970),
                                lastDate: DateTime.now());
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              DateTime selectedDate =
                                  DateTime.parse(formattedDate);
                              int selectedEpoch =
                                  selectedDate.millisecondsSinceEpoch;
                              DateTime now = DateTime.now();
                              int nowEpoch = now.millisecondsSinceEpoch;
                              //difference = (nowEpoch - selectedEpoch) /1000 /60 /60 /24 /365.25;  Epoch to year count
                              roundedDifference = double.parse(
                                  ((nowEpoch - selectedEpoch) /
                                          1000 /
                                          60 /
                                          60 /
                                          24 /
                                          365.25)
                                      .toStringAsFixed(2));
                              setState(() {
                                dateController.text = formattedDate;
                              });
                            }
                          },
                          //validator: (value) {},
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        //Login & Register
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () async => registerNow(),
                              color: Colors.white,
                              child: Text(
                                str.register,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextButton(
                          onPressed: () {
                            const CircularProgressIndicator();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Already Registered?   Sign-In',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showProgress)
              Positioned.fill(
                child: Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp(
      String name,
      String phone,
      String role,
      String country,
      String state,
      String city,
      String dob,
      double age,
      String imageUrl) async {
    //CircularProgressIndicator();
    setState(() {
      showProgress = true;
    });
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          //showToast("Verification Completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          //showToast("Verification Failed");
        },
        codeSent: (String verificationId, int? resendToken) async {
          showToast(str.otpSent);
          final isVerified = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyOtp(
                verificationId: verificationId,
              ),
            ),
          );
          if (isVerified) {
            await postDetailsToFirestore(
              name,
              phone,
              role,
              country,
              state,
              city,
              dob,
              age,
              imageUrl,
            );
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
    setState(() {
      showProgress = false;
    });
  }

  Future<void> postDetailsToFirestore(
    String name,
    String phone,
    String role,
    String country,
    String state,
    String city,
    String dob,
    double age,
    String imageUrl,
  ) async {
    List<String> listData = UserDataModel(
      name: name,
      role: role,
      city: city,
      state: state,
      country: country,
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

    await FirebaseRepository.instance.postUserDetailsToFirestore(
      UserModel(
        phone: phone,
        dob: dob,
        age: age,
        profileImage: imageUrl,
        englishUserData: engDataModel,
        gujaratiUserData: gujDataModel,
        hindiUserData: hinDataModel,
      ),
    );
  }

  Future<void> registerNow() async {
    if (nameController.text != null && nameController.text.isEmpty) {
      AnimatedSnackBar.material(
        str.nameCantEmpty,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (nameController.text.length < 3) {
      AnimatedSnackBar.material(
        str.msgCharacterMore2,
        type: AnimatedSnackBarType.warning,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }
    if (phoneController.text.length != 10) {
      AnimatedSnackBar.material(
        str.msgNumMust10Digit,
        type: AnimatedSnackBarType.error,
      ).show(context);
      return;
    }
    if (phoneController.text.contains(',') ||
        phoneController.text.contains('.') ||
        phoneController.text.contains('-') ||
        phoneController.text.contains(' ')) {
      AnimatedSnackBar.material(
        'str.invalideNumber',
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      return;
    }

    if (stateValue == null || stateValue == '') {
      AnimatedSnackBar.material(
        'str.stateNotEmpty',
        type: AnimatedSnackBarType.error,
      ).show(context);
      return;
    }

    if (cityValue == null || cityValue == '') {
      AnimatedSnackBar.material(
        'str.cityNotEmpty',
        type: AnimatedSnackBarType.error,
      ).show(context);
      return;
    }

    if (roundedDifference <= 18) {
      AnimatedSnackBar.material(
        str.msgUnder18,
        type: AnimatedSnackBarType.error,
      ).show(context);
      return;
    }

    if (_image == null) {
      AnimatedSnackBar.material(
        'str.uploadProfileImage',
        type: AnimatedSnackBarType.error,
      ).show(context);
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      final isExist = await FirebaseRepository.instance
          .checkPhoneNumberExists(countryCode + phoneController.text);
      if (isExist) {
        AnimatedSnackBar.material(
          str.msgAlreadyRegistered,
          type: AnimatedSnackBarType.error,
        ).show(context);
      } else {
        await _uploadImageToFirebase();
        if (roundedDifference >= 18 && _imageUrl != '') {
          await signUp(
              nameController.text,
              countryCode + phoneController.text,
              selectedRole,
              countryValue,
              stateValue!,
              cityValue!,
              dateController.text,
              roundedDifference,
              _imageUrl);
        } else {
          if (roundedDifference < 18) {
            showToast(str.msgUnder18);
          } else {
            showToast(str.msgUploadProfilePic);
          }
        }
      }
    }
  }
}
