import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'otp.dart';

class LoginPage extends StatefulWidget {
  static String verify = "";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController pinController = TextEditingController();
  var countryCode = "";
  bool visible = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryCode = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kDarkColor,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  str.login,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 90,
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
                const SizedBox(
                  height: 50,
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
                      onPressed: () async {
                        sendAndVerifyOTP();
                      },
                      color: Colors.white,
                      child: Text(
                        str.login,
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Not Register yet?   Register Now',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendAndVerifyOTP() async {
    if (phoneController.text.length != 10) {
      AnimatedSnackBar.material(
        str.msgNumMust10Digit,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
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

    final isExist = await FirebaseRepository.instance
        .checkPhoneNumberExists(countryCode + phoneController.text);
    try {
      if (isExist) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: countryCode + phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) {
            //pinController.setText(credential.smsCode);
          },
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) async {
            AnimatedSnackBar.material(
              str.otpSent,
              type: AnimatedSnackBarType.success,
            ).show(context);
            final isVerified = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyOtp(
                  verificationId: verificationId,
                ),
              ),
            );
            if (isVerified) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        AnimatedSnackBar.material(
          str.msgRegisteredNo,
          type: AnimatedSnackBarType.error,
        ).show(context);
      }
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(label: s.toString());
    }
  }
}
