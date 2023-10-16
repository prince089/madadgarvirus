import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_constants.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String? profileimage;
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    getUserImage();
  }

  Future<void> getUserImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    var doc = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollections)
        .doc(user!.uid)
        .get();
    final data = doc.data();
    if (data != null) {
      setState(() {
        data.containsKey('profileimage')
            ? profileimage = data["profileimage"]
            : Container();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          image: profileimage != null
              ? DecorationImage(
                  image: NetworkImage('$profileimage'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }

  updateProfilePicture(String imageUrl) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;

    CollectionReference ref = firebaseFirestore.collection('users');
    ref.doc(user!.uid).update({
      'profileimage': _imageUrl,
    });
  }
}

// String uniqueFileName =
//     DateTime.now().microsecondsSinceEpoch.toString();
//
// Reference referenceRoot = FirebaseStorage.instance.ref();
// Reference referenceDirImage =
//     referenceRoot.child("Profileimage");
//
// Reference referenceImageToUpload =
//     referenceDirImage.child(uniqueFileName);
