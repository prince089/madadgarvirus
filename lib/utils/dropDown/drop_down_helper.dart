import 'package:flutter/material.dart';

import '../form_constants.dart';

/// This is Model class. Using this model class, you can add the list of data with title and its selection.
class DropDownItemModel {
  bool? isSelected;
  String name;
  int value;

  DropDownItemModel({
    required this.name,
    required this.value,
    this.isSelected,
  });
}

List<DropdownMenuItem<DropDownItemModel>> addDividersAfterItems(
    List<DropDownItemModel> items) {
  List<DropdownMenuItem<DropDownItemModel>> menuItems = [];
  for (var item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<DropDownItemModel>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<DropDownItemModel>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return menuItems;
}

List<double> getCustomItemsHeights() {
  List<double> itemsHeights = [];
  for (var i = 0; i < (kJobTypeList.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(4);
    }
  }
  return itemsHeights;
}

List<double> getCustomItemsHeightsForPersonList() {
  List<double> itemsHeights = [];
  for (var i = 0; i < (kNoOfPersonList.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(4);
    }
  }
  return itemsHeights;
}

List<double> getCustomItemsHeightsForEducation() {
  List<double> itemsHeights = [];
  for (var i = 0; i < (kEducationDetailList.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(4);
    }
  }
  return itemsHeights;
}

List<double> getCustomItemsHeightsForWorkExperience() {
  List<double> itemsHeights = [];
  for (var i = 0; i < (kWorkExperienceList.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(4);
    }
  }
  return itemsHeights;
}
