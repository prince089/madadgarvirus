import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/requests/requests.dart';
import 'package:madadgarvirus/user_screen/profile/profile_screen.dart';

import '../../utils/app_constants.dart';
import '../farmer/create_new_job/job_form.dart';
import '../farmer/farmer_home.dart';
import '../resource_list.dart';
import '../worker/add_more_details/add_details.dart';
import '../worker/worker_home.dart';
import 'app_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;
  List<Widget>? _pages;

  @override
  void initState() {
    super.initState();
    checkRole();
  }

  Future<void> checkRole() async {
    final isFarmer = await FirebaseRepository.instance.isFarmerRoleRegistered();
    if (isFarmer) {
      _pages = [
        const FarmerHome(),
        const NewJobFormScreen(),
        const ResourceList(),
        Requests(),
        Center(
          child: ProfileScreen(isFarmer: true),
        ),
      ];
    } else {
      _pages = [
        const WorkerHome(),
        const AddMoreDetails(),
        const ResourceList(),
        Requests(),
        Center(
          child: ProfileScreen(isFarmer: false),
        )
      ];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kLighterColor,
      resizeToAvoidBottomInset: false,
      body: _pages == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _pages![_selectedIndex],
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _selectedIndex,
        onIndexChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
// ClipRRect(
// borderRadius: const BorderRadius.vertical(
// top: Radius.circular(15),
// ),
// child:
