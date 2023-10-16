import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/user_model.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/user_screen/worker/worker_filter_model.dart';
import 'package:madadgarvirus/user_screen/worker/worker_search_filter.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:madadgarvirus/utils/loading_widget.dart';

import 'farmer_detail_screen.dart';

class WorkerHome extends StatefulWidget {
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  String? langCode;
  List<UserModel> farmerList = [];
  bool isLoading = false;
  List<UserModel> filteredUser = [];

  @override
  void initState() {
    super.initState();
    langCode = LanguagePreference.getLanguage();
    fetchFarmerData();
  }

  Future<void> fetchFarmerData() async {
    setState(() {
      isLoading = true;
    });
    farmerList = await FirebaseRepository.instance.getAllFarmerList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(str.worker),
          backgroundColor: kDarkerColor,
          actions: [
            IconButton(
              onPressed: openFilterScreen,
              icon: const Icon(Icons.search_rounded),
            )
          ],
        ),
        body: AnimatedLoadingWidget(
          isLoading: isLoading,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: farmerList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 18,
            ),
            itemBuilder: (context, index) {
              final userModel = farmerList[index];
              final userDataModel = userModel.getUserDataModelFromCode(
                langCode: langCode,
              );
              return Container(
                padding: const EdgeInsets.all(8),
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
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userModel.profileImage),
                    radius: 40,
                  ),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            //document['name'],
                            userDataModel.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text(document['city'] + ', ' + document['state']),
                          // Text(document['country']),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 0,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerDetailsScreen(
                          userModel: userModel,
                          userDataModel: userDataModel,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> openFilterScreen() async {
    final filterModel = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WorkerSearchFilterScreen(),
      ),
    );
    if (filterModel != null && filterModel is WorkerFilterModel) {
      setState(() {
        isLoading = true;
      });
      final filter = filterModel;
      filteredUser = farmerList.where((element) {
        var result = element.hindiUserData.city == filter.city &&
            element.hindiUserData.state == filter.state &&
            element.job != null &&
            (int.tryParse(element.job!.fromValue ?? '0') ?? 0) >=
                filter.fromSalary &&
            (int.tryParse(element.job!.toValue ?? '0') ?? 0) <=
                filter.toSalary &&
            (int.tryParse(element.job!.landfieldValue ?? '0') ?? 0) <=
                filter.fromLandField &&
            (int.tryParse(element.job!.landfieldValue ?? '0') ?? 0) >=
                filter.toLandField &&
            element.job!.jobType == filter.jobType &&
            element.job!.noOfPerson == filter.noOfPerson &&
            element.job!.healthInsuranceValue == filter.healthInsurance &&
            element.job!.housingValue == filter.housingFacility;
        final filterCatValue = filter.category?.map((e) => e.value).toList();
        filterCatValue?.toSet().intersection(
              filter.category?.toSet() ?? {},
            );
        result = result && filterCatValue != null && filterCatValue.isNotEmpty;
        return result;
      }).toList();
      setState(() {
        isLoading = false;
      });
    }
  }
}
