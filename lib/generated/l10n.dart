// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Farmer`
  String get farmer {
    return Intl.message(
      'Farmer',
      name: 'farmer',
      desc: '',
      args: [],
    );
  }

  /// `Worker`
  String get worker {
    return Intl.message(
      'Worker',
      name: 'worker',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navBarHome {
    return Intl.message(
      'Home',
      name: 'navBarHome',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get navAdd {
    return Intl.message(
      'Add',
      name: 'navAdd',
      desc: '',
      args: [],
    );
  }

  /// `Articals`
  String get navBarArticals {
    return Intl.message(
      'Articals',
      name: 'navBarArticals',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get navBarRequests {
    return Intl.message(
      'Request',
      name: 'navBarRequests',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get navBarProfile {
    return Intl.message(
      'Profile',
      name: 'navBarProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get myAccount {
    return Intl.message(
      'My Account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Choose language`
  String get chooseLanguage {
    return Intl.message(
      'Choose language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Log-in`
  String get login {
    return Intl.message(
      'Log-in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNO {
    return Intl.message(
      'Phone Number',
      name: 'phoneNO',
      desc: '',
      args: [],
    );
  }

  /// `Enter Date`
  String get date {
    return Intl.message(
      'Enter Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `madadgarvirus`
  String get madadgarvirus {
    return Intl.message(
      'madadgarvirus',
      name: 'madadgarvirus',
      desc: '',
      args: [],
    );
  }

  /// `Phone Verification`
  String get phoneVerification {
    return Intl.message(
      'Phone Verification',
      name: 'phoneVerification',
      desc: '',
      args: [],
    );
  }

  /// `You have not registered with this number.\nPlease register to continue`
  String get msgRegisteredNo {
    return Intl.message(
      'You have not registered with this number.\nPlease register to continue',
      name: 'msgRegisteredNo',
      desc: '',
      args: [],
    );
  }

  /// `OTP has been sent`
  String get otpSent {
    return Intl.message(
      'OTP has been sent',
      name: 'otpSent',
      desc: '',
      args: [],
    );
  }

  /// `Verify the Code`
  String get verifyCode {
    return Intl.message(
      'Verify the Code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Edit Phone Number ?`
  String get editPhoneNo {
    return Intl.message(
      'Edit Phone Number ?',
      name: 'editPhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid 10 digit phone number`
  String get msgEnterValidNo {
    return Intl.message(
      'Enter valid 10 digit phone number',
      name: 'msgEnterValidNo',
      desc: '',
      args: [],
    );
  }

  /// `Under the age of 18 are ineligible for this app.`
  String get msgUnder18 {
    return Intl.message(
      'Under the age of 18 are ineligible for this app.',
      name: 'msgUnder18',
      desc: '',
      args: [],
    );
  }

  /// `You are already registered with this number.\nPlease log-in to continue`
  String get msgAlreadyRegistered {
    return Intl.message(
      'You are already registered with this number.\nPlease log-in to continue',
      name: 'msgAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number must be of 10 digit`
  String get msgNumMust10Digit {
    return Intl.message(
      'Mobile Number must be of 10 digit',
      name: 'msgNumMust10Digit',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get nameCantEmpty {
    return Intl.message(
      'Name cannot be empty',
      name: 'nameCantEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Name must be more than 2 charater`
  String get msgCharacterMore2 {
    return Intl.message(
      'Name must be more than 2 charater',
      name: 'msgCharacterMore2',
      desc: '',
      args: [],
    );
  }

  /// `OTP is invalid. Please try again..`
  String get msgInvalidOTP {
    return Intl.message(
      'OTP is invalid. Please try again..',
      name: 'msgInvalidOTP',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Upload Profile Picture to register`
  String get msgUploadProfilePic {
    return Intl.message(
      'Upload Profile Picture to register',
      name: 'msgUploadProfilePic',
      desc: '',
      args: [],
    );
  }

  /// `Extra`
  String get extra {
    return Intl.message(
      'Extra',
      name: 'extra',
      desc: '',
      args: [],
    );
  }

  /// `Request has been sent to {name}`
  String requestHasBeenSentToName(Object name) {
    return Intl.message(
      'Request has been sent to $name',
      name: 'requestHasBeenSentToName',
      desc: '',
      args: [name],
    );
  }

  /// `Request is deleted now`
  String get withdrawRequestToFarmer {
    return Intl.message(
      'Request is deleted now',
      name: 'withdrawRequestToFarmer',
      desc: '',
      args: [],
    );
  }

  /// `Pending Requests`
  String get pendingRequests {
    return Intl.message(
      'Pending Requests',
      name: 'pendingRequests',
      desc: '',
      args: [],
    );
  }

  /// `Accepted Requests`
  String get acceptedRequests {
    return Intl.message(
      'Accepted Requests',
      name: 'acceptedRequests',
      desc: '',
      args: [],
    );
  }

  /// `Posted Jobs`
  String get postedJobs {
    return Intl.message(
      'Posted Jobs',
      name: 'postedJobs',
      desc: '',
      args: [],
    );
  }

  /// `User Details`
  String get userDetails {
    return Intl.message(
      'User Details',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dob {
    return Intl.message(
      'Date of birth',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `How much acre of landfield you have ?`
  String get howMuchLandYouHave {
    return Intl.message(
      'How much acre of landfield you have ?',
      name: 'howMuchLandYouHave',
      desc: '',
      args: [],
    );
  }

  /// `Job Type`
  String get jobType {
    return Intl.message(
      'Job Type',
      name: 'jobType',
      desc: '',
      args: [],
    );
  }

  /// `Number of persons`
  String get noOfPersons {
    return Intl.message(
      'Number of persons',
      name: 'noOfPersons',
      desc: '',
      args: [],
    );
  }

  /// `Choose Categories`
  String get chooseCategories {
    return Intl.message(
      'Choose Categories',
      name: 'chooseCategories',
      desc: '',
      args: [],
    );
  }

  /// `Job Title`
  String get jobTitle {
    return Intl.message(
      'Job Title',
      name: 'jobTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hourly Rate`
  String get hourlyRate {
    return Intl.message(
      'Hourly Rate',
      name: 'hourlyRate',
      desc: '',
      args: [],
    );
  }

  /// `Fixed Salary`
  String get fixedSalary {
    return Intl.message(
      'Fixed Salary',
      name: 'fixedSalary',
      desc: '',
      args: [],
    );
  }

  /// `Per Acre`
  String get perAcre {
    return Intl.message(
      'Per Acre',
      name: 'perAcre',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Do you offer health insurance ?`
  String get doOfferHealthInsurance {
    return Intl.message(
      'Do you offer health insurance ?',
      name: 'doOfferHealthInsurance',
      desc: '',
      args: [],
    );
  }

  /// `Do you offer housing ?`
  String get doOfferHousing {
    return Intl.message(
      'Do you offer housing ?',
      name: 'doOfferHousing',
      desc: '',
      args: [],
    );
  }

  /// `Job Description (Optional)`
  String get jobDescription {
    return Intl.message(
      'Job Description (Optional)',
      name: 'jobDescription',
      desc: '',
      args: [],
    );
  }

  /// `Select Images`
  String get selectImages {
    return Intl.message(
      'Select Images',
      name: 'selectImages',
      desc: '',
      args: [],
    );
  }

  /// `Images Selected`
  String get imagesSelected {
    return Intl.message(
      'Images Selected',
      name: 'imagesSelected',
      desc: '',
      args: [],
    );
  }

  /// `Selected images are uploaded`
  String get imagesUploaded {
    return Intl.message(
      'Selected images are uploaded',
      name: 'imagesUploaded',
      desc: '',
      args: [],
    );
  }

  /// `List of selected images`
  String get listOfSelectedImages {
    return Intl.message(
      'List of selected images',
      name: 'listOfSelectedImages',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 3 Images allowed.`
  String get maxImagesAllowed {
    return Intl.message(
      'Maximum 3 Images allowed.',
      name: 'maxImagesAllowed',
      desc: '',
      args: [],
    );
  }

  /// `PUBLISH JOB`
  String get publishJob {
    return Intl.message(
      'PUBLISH JOB',
      name: 'publishJob',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for publishing job`
  String get thanksForPublishingJob {
    return Intl.message(
      'Thanks for publishing job',
      name: 'thanksForPublishingJob',
      desc: '',
      args: [],
    );
  }

  /// `Job category can\'t be empty`
  String get notEmptyJobCategory {
    return Intl.message(
      'Job category can\\\'t be empty',
      name: 'notEmptyJobCategory',
      desc: '',
      args: [],
    );
  }

  /// `Job title can\'t be empty`
  String get notEmptyJobTitle {
    return Intl.message(
      'Job title can\\\'t be empty',
      name: 'notEmptyJobTitle',
      desc: '',
      args: [],
    );
  }

  /// `Landfield can\'t be empty`
  String get notEmptyLandField {
    return Intl.message(
      'Landfield can\\\'t be empty',
      name: 'notEmptyLandField',
      desc: '',
      args: [],
    );
  }

  /// `Select Job Type`
  String get notEmptyJobType {
    return Intl.message(
      'Select Job Type',
      name: 'notEmptyJobType',
      desc: '',
      args: [],
    );
  }

  /// `Select number of persons you want to hire`
  String get notEmptyNoOfPerson {
    return Intl.message(
      'Select number of persons you want to hire',
      name: 'notEmptyNoOfPerson',
      desc: '',
      args: [],
    );
  }

  /// `From-To values can\'t be empty`
  String get notEmptyFromTo {
    return Intl.message(
      'From-To values can\\\'t be empty',
      name: 'notEmptyFromTo',
      desc: '',
      args: [],
    );
  }

  /// `Select at least 1 image`
  String get notEmptyImage {
    return Intl.message(
      'Select at least 1 image',
      name: 'notEmptyImage',
      desc: '',
      args: [],
    );
  }

  /// `Create New Job`
  String get createNewJob {
    return Intl.message(
      'Create New Job',
      name: 'createNewJob',
      desc: '',
      args: [],
    );
  }

  /// `Add more details`
  String get addMoreDetails {
    return Intl.message(
      'Add more details',
      name: 'addMoreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Intrested for`
  String get intrestedFor {
    return Intl.message(
      'Intrested for',
      name: 'intrestedFor',
      desc: '',
      args: [],
    );
  }

  /// `We are __ persons`
  String get weArePersons {
    return Intl.message(
      'We are __ persons',
      name: 'weArePersons',
      desc: '',
      args: [],
    );
  }

  /// `Work experience (In Years)`
  String get workExperience {
    return Intl.message(
      'Work experience (In Years)',
      name: 'workExperience',
      desc: '',
      args: [],
    );
  }

  /// `Are you currently employed ?`
  String get areYouEmployed {
    return Intl.message(
      'Are you currently employed ?',
      name: 'areYouEmployed',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Where ?`
  String get where {
    return Intl.message(
      'Where ?',
      name: 'where',
      desc: '',
      args: [],
    );
  }

  /// `What is your current wage ?`
  String get currentWage {
    return Intl.message(
      'What is your current wage ?',
      name: 'currentWage',
      desc: '',
      args: [],
    );
  }

  /// `What is your current job title ?`
  String get currentJobTitle {
    return Intl.message(
      'What is your current job title ?',
      name: 'currentJobTitle',
      desc: '',
      args: [],
    );
  }

  /// `How you prefer to get paid ?`
  String get preferToPaid {
    return Intl.message(
      'How you prefer to get paid ?',
      name: 'preferToPaid',
      desc: '',
      args: [],
    );
  }

  /// `Do you have driving license ?`
  String get haveDrivingLicense {
    return Intl.message(
      'Do you have driving license ?',
      name: 'haveDrivingLicense',
      desc: '',
      args: [],
    );
  }

  /// `Are you looking for housing\nwith employment opportunity?`
  String get lookingForHousing {
    return Intl.message(
      'Are you looking for housing\\nwith employment opportunity?',
      name: 'lookingForHousing',
      desc: '',
      args: [],
    );
  }

  /// `Education details can\'t be empty`
  String get notEmptyEducation {
    return Intl.message(
      'Education details can\\\'t be empty',
      name: 'notEmptyEducation',
      desc: '',
      args: [],
    );
  }

  /// `Work experience can\'t be empty`
  String get notEmptyWorkExperience {
    return Intl.message(
      'Work experience can\\\'t be empty',
      name: 'notEmptyWorkExperience',
      desc: '',
      args: [],
    );
  }

  /// `At where you are currently employed?`
  String get notEmptyWhereEmployed {
    return Intl.message(
      'At where you are currently employed?',
      name: 'notEmptyWhereEmployed',
      desc: '',
      args: [],
    );
  }

  /// `Harvesting`
  String get harvesting {
    return Intl.message(
      'Harvesting',
      name: 'harvesting',
      desc: '',
      args: [],
    );
  }

  /// `Mechanic`
  String get mechanic {
    return Intl.message(
      'Mechanic',
      name: 'mechanic',
      desc: '',
      args: [],
    );
  }

  /// `Planting`
  String get planting {
    return Intl.message(
      'Planting',
      name: 'planting',
      desc: '',
      args: [],
    );
  }

  /// `Truck Driver`
  String get truckDriver {
    return Intl.message(
      'Truck Driver',
      name: 'truckDriver',
      desc: '',
      args: [],
    );
  }

  /// `Cowboy`
  String get cowBoy {
    return Intl.message(
      'Cowboy',
      name: 'cowBoy',
      desc: '',
      args: [],
    );
  }

  /// `General Farm Work`
  String get generalFarmWork {
    return Intl.message(
      'General Farm Work',
      name: 'generalFarmWork',
      desc: '',
      args: [],
    );
  }

  /// `Water Management`
  String get waterManagement {
    return Intl.message(
      'Water Management',
      name: 'waterManagement',
      desc: '',
      args: [],
    );
  }

  /// `Crop care`
  String get cropCare {
    return Intl.message(
      'Crop care',
      name: 'cropCare',
      desc: '',
      args: [],
    );
  }

  /// `Dirt or rock removal/Hauling`
  String get dirtOrRockRemoval {
    return Intl.message(
      'Dirt or rock removal/Hauling',
      name: 'dirtOrRockRemoval',
      desc: '',
      args: [],
    );
  }

  /// `Machinery Upkeep`
  String get machineryUpkeep {
    return Intl.message(
      'Machinery Upkeep',
      name: 'machineryUpkeep',
      desc: '',
      args: [],
    );
  }

  /// `Tilling`
  String get tilling {
    return Intl.message(
      'Tilling',
      name: 'tilling',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get jobs {
    return Intl.message(
      'Jobs',
      name: 'jobs',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Full Time`
  String get fullTime {
    return Intl.message(
      'Full Time',
      name: 'fullTime',
      desc: '',
      args: [],
    );
  }

  /// `Part Time`
  String get partTime {
    return Intl.message(
      'Part Time',
      name: 'partTime',
      desc: '',
      args: [],
    );
  }

  /// `Seasonal`
  String get seasonal {
    return Intl.message(
      'Seasonal',
      name: 'seasonal',
      desc: '',
      args: [],
    );
  }

  /// `One Time Job`
  String get oneTimeJob {
    return Intl.message(
      'One Time Job',
      name: 'oneTimeJob',
      desc: '',
      args: [],
    );
  }

  /// `0`
  String get zero {
    return Intl.message(
      '0',
      name: 'zero',
      desc: '',
      args: [],
    );
  }

  /// `1`
  String get one {
    return Intl.message(
      '1',
      name: 'one',
      desc: '',
      args: [],
    );
  }

  /// `2`
  String get two {
    return Intl.message(
      '2',
      name: 'two',
      desc: '',
      args: [],
    );
  }

  /// `3`
  String get three {
    return Intl.message(
      '3',
      name: 'three',
      desc: '',
      args: [],
    );
  }

  /// `More Than 5`
  String get moreThan5 {
    return Intl.message(
      'More Than 5',
      name: 'moreThan5',
      desc: '',
      args: [],
    );
  }

  /// `More Than 10`
  String get moreThan10 {
    return Intl.message(
      'More Than 10',
      name: 'moreThan10',
      desc: '',
      args: [],
    );
  }

  /// `More Than 15`
  String get moreThan15 {
    return Intl.message(
      'More Than 15',
      name: 'moreThan15',
      desc: '',
      args: [],
    );
  }

  /// `More Than 20`
  String get moreThan20 {
    return Intl.message(
      'More Than 20',
      name: 'moreThan20',
      desc: '',
      args: [],
    );
  }

  /// `Associates of Science`
  String get associatesOfScience {
    return Intl.message(
      'Associates of Science',
      name: 'associatesOfScience',
      desc: '',
      args: [],
    );
  }

  /// `Bachelors`
  String get bachelors {
    return Intl.message(
      'Bachelors',
      name: 'bachelors',
      desc: '',
      args: [],
    );
  }

  /// `High School Diploma`
  String get highSchoolDiploma {
    return Intl.message(
      'High School Diploma',
      name: 'highSchoolDiploma',
      desc: '',
      args: [],
    );
  }

  /// `Masters`
  String get masters {
    return Intl.message(
      'Masters',
      name: 'masters',
      desc: '',
      args: [],
    );
  }

  /// `Some College`
  String get someCollege {
    return Intl.message(
      'Some College',
      name: 'someCollege',
      desc: '',
      args: [],
    );
  }

  /// `Still in high school`
  String get stillInHighSchool {
    return Intl.message(
      'Still in high school',
      name: 'stillInHighSchool',
      desc: '',
      args: [],
    );
  }

  /// `Trade School`
  String get tradeSchool {
    return Intl.message(
      'Trade School',
      name: 'tradeSchool',
      desc: '',
      args: [],
    );
  }

  /// `Not educated`
  String get notEducated {
    return Intl.message(
      'Not educated',
      name: 'notEducated',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `Edit Job`
  String get editJob {
    return Intl.message(
      'Edit Job',
      name: 'editJob',
      desc: '',
      args: [],
    );
  }

  /// `My Skills`
  String get mySkills {
    return Intl.message(
      'My Skills',
      name: 'mySkills',
      desc: '',
      args: [],
    );
  }

  /// `Job Details`
  String get jobDetails {
    return Intl.message(
      'Job Details',
      name: 'jobDetails',
      desc: '',
      args: [],
    );
  }

  /// `Salary Preference`
  String get salaryPreference {
    return Intl.message(
      'Salary Preference',
      name: 'salaryPreference',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get salaryFromTo {
    return Intl.message(
      'Salary',
      name: 'salaryFromTo',
      desc: '',
      args: [],
    );
  }

  /// `Current Employment`
  String get currentEmployment {
    return Intl.message(
      'Current Employment',
      name: 'currentEmployment',
      desc: '',
      args: [],
    );
  }

  /// `Not Employed`
  String get notEmployed {
    return Intl.message(
      'Not Employed',
      name: 'notEmployed',
      desc: '',
      args: [],
    );
  }

  /// `Working at`
  String get workingAt {
    return Intl.message(
      'Working at',
      name: 'workingAt',
      desc: '',
      args: [],
    );
  }

  /// `At wage`
  String get wage {
    return Intl.message(
      'At wage',
      name: 'wage',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Have Health Insurance`
  String get haveHealthInsurance {
    return Intl.message(
      'Have Health Insurance',
      name: 'haveHealthInsurance',
      desc: '',
      args: [],
    );
  }

  /// `Have Driving Licence`
  String get haveDrivingLicence {
    return Intl.message(
      'Have Driving Licence',
      name: 'haveDrivingLicence',
      desc: '',
      args: [],
    );
  }

  /// `Looking For Housing At Work`
  String get lookingForHousingAtWork {
    return Intl.message(
      'Looking For Housing At Work',
      name: 'lookingForHousingAtWork',
      desc: '',
      args: [],
    );
  }

  /// `Job Description`
  String get fatchJobDescription {
    return Intl.message(
      'Job Description',
      name: 'fatchJobDescription',
      desc: '',
      args: [],
    );
  }

  /// `About Job`
  String get aboutJob {
    return Intl.message(
      'About Job',
      name: 'aboutJob',
      desc: '',
      args: [],
    );
  }

  /// `Required Job Skills`
  String get requiredJobSkills {
    return Intl.message(
      'Required Job Skills',
      name: 'requiredJobSkills',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get salary {
    return Intl.message(
      'Salary',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `Number of persons needed`
  String get noOfPersonNeeded {
    return Intl.message(
      'Number of persons needed',
      name: 'noOfPersonNeeded',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'gu', countryCode: 'IN'),
      Locale.fromSubtags(languageCode: 'hi', countryCode: 'IN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
