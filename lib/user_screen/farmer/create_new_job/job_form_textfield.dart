import 'package:flutter/material.dart';

import '../../../utils/dropDown/drop_down.dart';
import '../../../utils/dropDown/drop_down_helper.dart';
import '../../../utils/helper.dart';

/// This is Common App textfiled class.
class JobFormTextField extends StatefulWidget {
  final TextEditingController textEditingController;

  //final String title;
  final String hint;
  final bool isDropDown;
  final List<DropDownItemModel>? jobs;
  final Function(List<DropDownItemModel> selectedItems)? onDone;

  const JobFormTextField({
    required this.textEditingController,
    //required this.title,
    required this.hint,
    required this.isDropDown,
    this.jobs,
    this.onDone,
    Key? key,
  }) : super(key: key);

  @override
  State<JobFormTextField> createState() => _JobFormTextFieldState();
}

class _JobFormTextFieldState extends State<JobFormTextField> {
  List<String> selectedCategory = [];

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          // height: 100,
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
          child: TextFormField(
            controller: widget.textEditingController,
            cursorColor: Colors.black,
            onTap: widget.isDropDown
                ? () {
                    FocusScope.of(context).unfocus();
                    openCategoryDropDown();
                  }
                : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
              hintText: widget.hint,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        // const SizedBox(
        //   height: 15.0,
        // ),
      ],
    );
  }

  /// This is on text changed method which will display on city text field on changed.
  void openCategoryDropDown() {
    DropDownState(
      DropDown(
        bottomSheetTitle: Text(
          str.jobs,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: Text(
          str.done,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.jobs ?? [],
        selectedItems: (selectedList) {
          widget.onDone?.call(selectedList);
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
  }
}

/// This is common class for 'PUBLISH JOB' elevated button.
// class _AppElevatedButton extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.05,
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           primary: kDarkColor,
//           textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         child: const Text(
//           kPublishJob,
//           style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:madadgarvirus/utils/app_constants.dart';
// import 'package:madadgarvirus/utils/helper.dart';
//
// import 'create_new_job/drop_down.dart';
// import 'create_new_job/drop_down_helper.dart';
//
// // Multi Select widget
// // This widget is reusable
// class MultiSelect extends StatefulWidget {
//   final List<String> items;
//   const MultiSelect({Key? key, required this.items}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }
//
// class _MultiSelectState extends State<MultiSelect> {
//   // this variable holds the selected items
//   final List<String> _selectedItems = [];
//
// // This function is triggered when a checkbox is checked or unchecked
//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }
//
//   // this function is called when the Cancel button is pressed
//   void _cancel() {
//     Navigator.pop(context);
//   }
//
// // this function is called when the Submit button is tapped
//   void _submit() {
//     Navigator.pop(context, _selectedItems);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Select Topics'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: widget.items
//               .map((item) => CheckboxListTile(
//                     value: _selectedItems.contains(item),
//                     title: Text(item),
//                     controlAffinity: ListTileControlAffinity.leading,
//                     onChanged: (isChecked) => _itemChange(item, isChecked!),
//                   ))
//               .toList(),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _cancel,
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _submit,
//           child: const Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
//
// class RequestPage extends StatefulWidget {
//   const RequestPage({Key? key}) : super(key: key);
//
//   @override
//   State<RequestPage> createState() => _RequestPageState();
// }
//
// class _RequestPageState extends State<RequestPage> {
//   List<String> _selectedItems = [
//         'Cowboy',
//         'Crop care',
//         'Equipment Maintenance',
//         'Trucking-Fertiliser/Chemical',
//         'Water Management',
//         'Tillage',
//         'Truck Driver',
//         'Mechanic',
//         'Operator',
//         'Planting',
//         'General Farm Work',
//         'Harvesting',
//         'Custom:Harvest',
//         'Custom-Plnting'
//   ];
//   //
//   // void _showMultiSelect() async {
//   //   // a list of selectable items
//   //   // these items can be hard-coded or dynamically fetched from a database/API
//   //   final List<String> items = [
//   //     'Cowboy',
//   //     'Crop care',
//   //     'Equipment Maintenance',
//   //     'Trucking-Fertiliser/Chemical',
//   //     'Water Management',
//   //     'Tillage',
//   //     'Truck Driver',
//   //     'Mechanic',
//   //     'Operator',
//   //     'Planting',
//   //     'General Farm Work',
//   //     'Harvesting',
//   //     'Custom:Harvest',
//   //     'Custom-Plnting'
//   //   ];
//   //
//   //   final List<String>? results = await showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return MultiSelect(items: items);
//   //     },
//   //   );
//   //
//   //   // Update UI
//   //   if (results != null) {
//   //     setState(() {
//   //       _selectedItems = results;
//   //     });
//   //   }
//   // }
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text(str.navBarRequests),
//   //       backgroundColor: kDarkerColor,
//   //     ),
//   //     body: Padding(
//   //       padding: const EdgeInsets.all(20),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           // use this button to open the multi-select dialog
//   //           SizedBox(
//   //             width: double.infinity,
//   //             child: ElevatedButton(
//   //               onPressed: _showMultiSelect,
//   //               style: const ButtonStyle(),
//   //               child: const Text('Job Category'),
//   //             ),
//   //           ),
//   //           const Divider(
//   //             height: 30,
//   //           ),
//   //           // display selected items
//   //           Wrap(
//   //             children: _selectedItems
//   //                 .map((e) => Chip(
//   //                       label: Text(e),
//   //                     ))
//   //                 .toList(),
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(str.navBarRequests),
//           backgroundColor: kDarkerColor,
//         ),
//         body: Center(
//           child: Container(
//             margin: EdgeInsets.all(18),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   color: Colors.teal,
//                   child: DropDownState(
//                     DropDown(
//                       bottomSheetTitle: const Text(
//                         'job category',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0,
//                         ),
//                       ),
//                       submitButtonChild: const Text(
//                         'Done',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       data: widget.cities ?? [],
//                       selectedItems: (List<dynamic> selectedList) {
//                         List<String> list = [];
//                         for(var item in selectedList) {
//                           if(item is SelectedListItem) {
//                             list.add(item.name);
//                           }
//                         }
//                         showSnackBar(list.toString());
//                       },
//                       enableMultipleSelection: true,
//                     ),
//                   ).showModal(context);
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
