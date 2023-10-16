import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/user_model.dart';
import 'package:madadgarvirus/model/worker_details_model.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/dropDown/drop_down_helper.dart';
import 'package:madadgarvirus/utils/extension.dart';
import 'package:madadgarvirus/utils/form_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:madadgarvirus/utils/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerDetailsScreen extends StatefulWidget {
  final UserModel userModel;
  final UserDataModel userDataModel;
  final bool isFromPendingScreen;

  const WorkerDetailsScreen({
    super.key,
    required this.userModel,
    required this.userDataModel,
    this.isFromPendingScreen = false,
  });

  @override
  State<WorkerDetailsScreen> createState() => _WorkerDetailsScreenState();
}

class _WorkerDetailsScreenState extends State<WorkerDetailsScreen> {
  bool isRequested = false;
  bool isAccepted = false;
  bool isApproved = false;
  bool isLoading = true;
  bool rejected = false;
  bool accepted = false;
  String? langCode;
  bool get hasDetails => widget.userModel.moreDetail != null;
  WorkerDetailsModel? get details => widget.userModel.moreDetail;
  WorkerJobInfoModel? jobInfoModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRequestedStatus();
    if (details != null) {
      langCode = LanguagePreference.getLanguage();
      jobInfoModel = details!.getJobInfoModelFromCode(langCode: langCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: context.height20,
                  //padding: const EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.radius50),
                      topRight: Radius.circular(context.radius50),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.userModel.profileImage),
                          radius: 50,
                        ),
                        const SizedBox(width: 24.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.userDataModel.name} (${widget.userDataModel.role})',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              '${widget.userModel.age}',
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, right: 10),
                                      child: Text(
                                        str.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        widget.userDataModel.name,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, right: 10),
                                      child: Text(
                                        str.age,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        '${widget.userModel.age}',
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, right: 10),
                                      child: Text(
                                        str.phoneNO,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: isApproved
                                          ? InkWell(
                                              onTap: () async {
                                                makingPhoneCall(
                                                    '${widget.userModel.phone}');
                                              },
                                              child: Text(
                                                '${widget.userModel.phone}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                  color: Colors.blue.shade300,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              '+91 **********',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                height: 1.8,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                if (details?.selectedEducationValue != null)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10, right: 10),
                                        child: Text(
                                          str.education,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          kEducationDetailList[details!
                                                  .selectedEducationValue!]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (details?.workExperienceValue != null)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10, right: 10),
                                        child: Text(
                                          str.workExperience,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          kWorkExperienceList[
                                                  details!.workExperienceValue!]
                                              .name,
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
                            Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, right: 10),
                                      child: Text(
                                        str.country,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        widget.userDataModel.country!,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, right: 10),
                                      child: Text(
                                        str.state,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        widget.userDataModel.state!,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, right: 10),
                                      child: Text(
                                        str.city,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        widget.userDataModel.city!,
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
                    if (details?.selectedCategory != null)
                      Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(18),
                        width: double.infinity,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              str.mySkills,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            getCategoryList(),
                          ],
                        ),
                      ),
                    hasDetails ? const SizedBox(height: 20.0) : Container(),
                    if (hasDetails) ...{
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                str.jobDetails,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              const SizedBox(height: 24.0),
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: [
                                  if (details?.jobType != null)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10, right: 10),
                                          child: Text(
                                            str.jobType,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            kJobTypeList[details!.jobType!]
                                                .name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (details?.salaryPreference != null)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10, right: 10),
                                          child: Text(
                                            str.salaryPreference,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            kSalaryPreferenceList[
                                                    details!.salaryPreference!]
                                                .name,
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10, right: 10),
                                        child: Text(
                                          str.salaryFromTo,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                      langCode == 'hi' || langCode == 'gu'
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Text(
                                                '${details!.fromValue} ${str.from} ${details!.toValue}  ${str.to} ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Text(
                                                '${str.from} ${details!.fromValue} ${str.to} ${details!.toValue}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  if (details!.noOfPerson != null)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10, right: 10),
                                          child: Text(
                                            str.noOfPersons,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            kNoOfPersonList[
                                                    details!.noOfPerson!]
                                                .name,
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
                      if (details!.isEmployed)
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
                                  str.currentEmployment,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 24.0),
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10, right: 10),
                                          child: Text(
                                            str.workingAt,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            jobInfoModel!.atWhereEmployed!,
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10, right: 10),
                                          child: Text(
                                            str.wage,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            details!.currentWage!,
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10, right: 10),
                                          child: Text(
                                            str.jobTitle,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            jobInfoModel!.jobTitle!,
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
                                const SizedBox(height: 30.0),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(18),
                        width: double.infinity,
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
                                str.details,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              const SizedBox(height: 24.0),
                              Table(
                                // defaultColumnWidth: FixedColumnWidth(170.0),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10, right: 10),
                                        child: Text(
                                          str.haveHealthInsurance,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          details!.healthInsuranceValue
                                              ? 'Yes'
                                              : 'No',
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10, right: 10),
                                        child: Text(
                                          str.haveDrivingLicence,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          details!.drivingLicenseValue
                                              ? 'Yes'
                                              : 'No',
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10, right: 10),
                                        child: Text(
                                          str.lookingForHousingAtWork,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          details!.housingValue ? 'Yes' : 'No',
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      if (jobInfoModel?.jobDescription != null)
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
                                  str.fatchJobDescription,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 24.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        jobInfoModel!.jobDescription!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30.0),
                              ],
                            ),
                          ),
                        )
                    },
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.isFromPendingScreen) ...{
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (!rejected && !accepted)
                                  ? () async {
                                      showToast(
                                          'Request from the ${widget.userDataModel.name} has been rejected');
                                      await FirebaseRepository.instance
                                          .rejectRequestFromTheWorker(
                                        widget.userModel.docId!,
                                      );
                                      setState(() {
                                        rejected = true;
                                      });
                                    }
                                  : () {
                                      rejected
                                          ? showToast(
                                              'Request is already Rejected.')
                                          : showToast(
                                              'Request is already Accepted.');
                                    },
                              style: ElevatedButton.styleFrom(
                                elevation: 6.0,
                                backgroundColor: !rejected && !accepted
                                    ? Colors.red.shade500
                                    : Colors.grey,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: FittedBox(
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: !rejected && !accepted
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (!rejected && !accepted)
                                  ? () async {
                                      showToast(
                                          '${widget.userDataModel.name}s request accepted');
                                      await FirebaseRepository.instance
                                          .acceptWorkerRequest(
                                        widget.userModel.docId!,
                                      );
                                      setState(() {
                                        accepted = true;
                                      });
                                    }
                                  : () {
                                      accepted
                                          ? showToast(
                                              'Request is already Accepted.')
                                          : showToast(
                                              'Request is already Rejected.');
                                    },
                              style: ElevatedButton.styleFrom(
                                elevation: 6.0,
                                backgroundColor: !rejected && !accepted
                                    ? kDarkColor
                                    : Colors.grey,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: FittedBox(
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: !rejected && !accepted
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    } else if (!isApproved) ...{
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {
                              sendRequest();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 6.0,
                              backgroundColor:
                                  isRequested ? Colors.grey : kDarkColor,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isRequested
                                        ? 'Already Requested'
                                        : isAccepted
                                            ? 'Remove from accepted list'
                                            : 'Request to contact',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    },
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendRequest() async {
    setState(() {
      isLoading = true;
    });
    if (isAccepted) {
      showToast('Removed From Allowed List');
      await FirebaseRepository.instance
          .removeFromAcceptedListOfFarmer(widget.userModel.docId ?? '');
      setState(() {
        isAccepted = false;
      });
    } else if (isRequested) {
      showToast(str.withdrawRequestToFarmer);
      await FirebaseRepository.instance
          .withdrawRequestToFarmer(widget.userModel.docId ?? '');
      setState(() {
        isRequested = false;
      });
    } else {
      //showToast(str.msgRequestSent);
      showToast(
          str.requestHasBeenSentToName(widget.userDataModel.name as Object));
      await FirebaseRepository.instance
          .sendRequestToFarmer(widget.userModel.docId ?? '');
      setState(() {
        isRequested = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> checkRequestedStatus() async {
    setState(() {
      isLoading = true;
    });
    isRequested = await FirebaseRepository.instance.alreadyRequestedToFarmer(
      widget.userModel.docId!,
    );
    if (!isRequested) {
      isAccepted = await FirebaseRepository.instance.alreadyAcceptedToFarmer(
        widget.userModel.docId!,
      );
    }
    isApproved = await FirebaseRepository.instance.alreadyApprovedToFarmer(
      widget.userModel.docId!,
    );
    setState(() {
      isLoading = false;
    });
  }

  Widget getCategoryList() {
    final selectedJobCategoryList = <DropDownItemModel>[];
    final sCategory = details!.selectedCategory!;
    for (final index in sCategory) {
      selectedJobCategoryList.add(kListOfJobs[index]);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        selectedJobCategoryList
            .map((e) => e.name)
            .toList()
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(',', '\t,\t\t'),
        //Todo: .join() not working
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 1.4,
        ),
      ),
    );
  }

  makingPhoneCall(String phoneNo) async {
    var url = Uri.parse("tel:$phoneNo");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
