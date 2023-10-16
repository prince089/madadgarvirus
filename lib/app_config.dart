import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/first_select_language.dart';
import 'package:madadgarvirus/user_screen/dashboard/home_screen.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
//import 'package:video_player/video_player.dart';

class AppConfig extends StatefulWidget {
  const AppConfig({Key? key}) : super(key: key);

  @override
  State<AppConfig> createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  var auth = FirebaseAuth.instance;
  bool isLogin = false;
  bool isFarmer = false;
  bool isLoading = false;
  // late VideoPlayerController controller;

  void checkIfLogin() {
    setState(() {
      isLoading = true;
    });
    auth.authStateChanges().listen((User? user) async {
      setState(() {
        isLoading = true;
      });
      if (user != null && mounted) {
        isLogin = true;
        isFarmer = await FirebaseRepository.instance.isFarmerRoleRegistered();
      } else {
        isLogin = false;
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfLogin();
    // controller = VideoPlayerController.asset('assets/madadgarvirus_loading.mp4')
    //   ..initialize().then((_) {
    //     setState(() {});
    //     controller.addListener(() {
    //       if (controller.value.position == controller.value.duration) {
    //         setState(() {
    //           isLoading = false;
    //         });
    //       }
    //     });
    //     controller.play();
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            // child: AspectRatio(
            //   aspectRatio: controller.value.aspectRatio,
            //   child: VideoPlayer(controller),
            // ),
            child: CircularProgressIndicator(
              color: Colors.green,
              backgroundColor: Colors.white,
            ),
          )
        : isLogin
            ? const HomeScreen()
            : const SelectLanguage();
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
}
