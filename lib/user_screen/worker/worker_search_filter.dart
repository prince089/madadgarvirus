import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/model/user_model.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/extension.dart';
import 'package:madadgarvirus/utils/helper.dart';

import '../../utils/dropDown/drop_down_helper.dart';
import '../../utils/form_constants.dart';
import 'worker_filter_model.dart';

class WorkerSearchFilterScreen extends StatefulWidget {
  const WorkerSearchFilterScreen({super.key});

  @override
  WorkerSearchFilterScreenState createState() =>
      WorkerSearchFilterScreenState();
}

class WorkerSearchFilterScreenState extends State<WorkerSearchFilterScreen> {
  // initialize filter values
  WorkerFilterModel filterModel = WorkerFilterModel();

  // build the search filter UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filters'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: kDarkerColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          // Expanded is added
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  height: context.width101,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: kDarkerColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) => showToast(value),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search Here",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      const Text(
                        'At where you are looking for work',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CSCPicker(
                          disabledDropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          layout: Layout.vertical,
                          flagState: CountryFlag.DISABLE,
                          defaultCountry: CscCountry.India,
                          disableCountry: true,
                          onCountryChanged: (value) {},
                          onStateChanged: (value) {
                            setState(() {
                              filterModel.state = value;
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              filterModel.city = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Salary Range (From - To)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: RangeValues(
                          filterModel.fromSalary.toDouble(),
                          filterModel.toSalary.toDouble(),
                        ),
                        min: 0,
                        max: 10000,
                        divisions: 1000,
                        activeColor: kDarkColor,
                        labels: RangeLabels('₹${filterModel.fromSalary}',
                            '₹${filterModel.toSalary}'),
                        onChanged: (RangeValues values) {
                          setState(() {
                            filterModel.fromSalary = values.start.toInt();
                            filterModel.toSalary = values.end.toInt();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      const Text(
                        'No of Landfield (In Acre)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: RangeValues(
                          filterModel.fromLandField.toDouble(),
                          filterModel.toLandField.toDouble(),
                        ),
                        min: 0,
                        max: 500,
                        divisions: 100,
                        activeColor: kDarkColor,
                        labels: RangeLabels(
                          '${filterModel.fromLandField}',
                          '${filterModel.toLandField}',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            filterModel.fromLandField = values.start.toInt();
                            filterModel.toLandField = values.end.toInt();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Wrap(
                        runSpacing: 10.0,
                        spacing: 10,
                        children: kListOfJobs
                            .map((category) => FilterChip(
                                  label: Text(
                                    category.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  selectedColor: kDarkColor,
                                  backgroundColor: Colors.grey,
                                  selected: filterModel.category!.indexWhere(
                                          (e) => e.name == category.name) !=
                                      -1,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        filterModel.category!.add(category);
                                      } else {
                                        filterModel.category!.removeWhere(
                                          (e) => e.name == category.name,
                                        );
                                      }
                                    });
                                  },
                                  checkmarkColor: Colors.white,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Job Type',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Padding(padding: EdgeInsets.all(7.0)),
                      Wrap(
                        runSpacing: 10.0,
                        spacing: 10,
                        children: kJobTypeList
                            .map((jobType) => FilterChip(
                                  label: Text(
                                    jobType.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  selectedColor: kDarkColor,
                                  backgroundColor: Colors.grey,
                                  checkmarkColor: Colors.white,
                                  selected:
                                      filterModel.jobType == jobType.value,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (filterModel.jobType ==
                                          jobType.value) {
                                        filterModel.jobType = null;
                                      } else {
                                        filterModel.jobType = jobType.value;
                                      }
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Number of Persons',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Padding(padding: EdgeInsets.all(7.0)),
                      Wrap(
                        runSpacing: 10.0,
                        spacing: 10,
                        children: kNoOfPersonList
                            .map((persons) => FilterChip(
                                  label: Text(
                                    persons.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  selectedColor: kDarkColor,
                                  backgroundColor: Colors.grey,
                                  checkmarkColor: Colors.white,
                                  selected:
                                      filterModel.noOfPerson == persons.value,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (filterModel.noOfPerson ==
                                          persons.value) {
                                        filterModel.noOfPerson = null;
                                      } else {
                                        filterModel.noOfPerson = persons.value;
                                      }
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Center(
                                    child: Text(
                                      'Looking for Health Insurance facility',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                CupertinoSwitch(
                                  activeColor: kDarkColor,
                                  value: filterModel.healthInsurance,
                                  onChanged: (value) {
                                    setState(() {
                                      filterModel.healthInsurance = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Center(
                                    child: Text(
                                      'Looking for housing facility',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                CupertinoSwitch(
                                  activeColor: kDarkColor,
                                  value: filterModel.housingFacility,
                                  onChanged: (value) {
                                    setState(() {
                                      filterModel.housingFacility = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kDarkColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(filterModel);
                    },
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(color: Colors.white),
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
}
