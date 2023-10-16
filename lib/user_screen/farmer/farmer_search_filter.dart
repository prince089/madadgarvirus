import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/user_screen/worker/worker_filter_model.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/extension.dart';
import 'package:madadgarvirus/utils/helper.dart';

import '../../utils/dropDown/drop_down_helper.dart';
import '../../utils/form_constants.dart';

class FarmerSearchFilterScreen extends StatefulWidget {
  const FarmerSearchFilterScreen({super.key});

  @override
  FarmerSearchFilterScreenState createState() =>
      FarmerSearchFilterScreenState();
}

class FarmerSearchFilterScreenState extends State<FarmerSearchFilterScreen> {
  // initialize filter values
  double _minPrice = 0;
  double _maxPrice = 1000;
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  bool _haveDrivingLicense = false;
  bool _haveHealthInsurance = false;
  final List<DropDownItemModel> _selectedJobCategory = [];
  int? _selectedJobType;
  int? _selectedWorkExperience;
  int? _selectedNoOfPersons;

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
                        'Salary Range (From - To)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: RangeValues(_minPrice, _maxPrice),
                        min: 0,
                        max: 10000,
                        divisions: 1000,
                        activeColor: kDarkColor,
                        labels: RangeLabels('₹$_minPrice', '₹$_maxPrice'),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _minPrice = values.start.truncateToDouble();
                            _maxPrice = values.end.truncateToDouble();
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
                                  selected: _selectedJobCategory.indexWhere(
                                          (e) => e.name == category.name) !=
                                      -1,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedJobCategory.add(category);
                                      } else {
                                        _selectedJobCategory.removeWhere(
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
                                  selected: _selectedJobType == jobType.value,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (_selectedJobType == jobType.value) {
                                        _selectedJobType = null;
                                      } else {
                                        _selectedJobType = jobType.value;
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
                      const Text('Clear'),
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
                                      _selectedNoOfPersons == persons.value,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (_selectedNoOfPersons ==
                                          persons.value) {
                                        _selectedNoOfPersons = null;
                                      } else {
                                        _selectedNoOfPersons = persons.value;
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
                        'Work Experience (In Years)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Padding(padding: EdgeInsets.all(7.0)),
                      Wrap(
                        runSpacing: 10.0,
                        spacing: 10,
                        children: kWorkExperienceList
                            .map(
                              (years) => FilterChip(
                                label: Text(
                                  years.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                selectedColor: kDarkColor,
                                backgroundColor: Colors.grey,
                                selected:
                                    _selectedWorkExperience == years.value,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (_selectedWorkExperience ==
                                        years.value) {
                                      _selectedWorkExperience = null;
                                    } else {
                                      _selectedWorkExperience = years.value;
                                    }
                                  });
                                },
                              ),
                            )
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
                                      'Worker should have Driving Licence',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                CupertinoSwitch(
                                  activeColor: kDarkColor,
                                  value: _haveDrivingLicense,
                                  onChanged: (value) {
                                    setState(() {
                                      _haveDrivingLicense = value;
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
                                      'Worker should have Health Insurance',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                CupertinoSwitch(
                                  activeColor: kDarkColor,
                                  value: _haveHealthInsurance,
                                  onChanged: (value) {
                                    setState(() {
                                      _haveHealthInsurance = value;
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
                      // TODO: apply filters
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
