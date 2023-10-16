import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/user_screen/profile/my_account.dart';
import 'package:madadgarvirus/utils/helper.dart';

import '../../../requests/approved_requests.dart';
import '../../profile/change_language.dart';
import '../../profile/extra.dart';
import '../../profile/profile_menu.dart';
import '../../profile/profile_pic.dart';

class WorkerProfileBody extends StatefulWidget {
  const WorkerProfileBody({super.key});

  @override
  State<WorkerProfileBody> createState() => _WorkerProfileBodyState();
}

class _WorkerProfileBodyState extends State<WorkerProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: str.myAccount,
            icon: "assets/User Icon.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
          ),
          ProfileMenu(
            text: 'Approved Requests',
            icon: "assets/User Icon.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ApprovedRequests()),
              );
            },
          ),
          ProfileMenu(
              text: str.changeLanguage,
              icon: "assets/language.svg",
              press: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangeLanguage()),
                );
              }),
          ProfileMenu(
              text: str.extra,
              icon: "assets/language.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Extra()),
                );
              }),
          ProfileMenu(
            text: str.logOut,
            icon: "assets/Log out.svg",
            press: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(
      context,
      ModalRoute.withName('/'),
    );
  }
}
