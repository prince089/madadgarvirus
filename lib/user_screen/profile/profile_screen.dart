import 'package:flutter/material.dart';
import 'package:madadgarvirus/user_screen/worker/profile/worker_profile_body.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';

import '../farmer/profile/farmer_profile_body.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    Key? key,
    required this.isFarmer,
  }) : super(key: key);

  final bool isFarmer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(str.navBarProfile),
        backgroundColor: kDarkerColor,
      ),
      body: isFarmer ? const FarmerProfileBody() : const WorkerProfileBody(),
    );
  }
}
