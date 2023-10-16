import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:madadgarvirus/model/new_job_model.dart';
import 'package:madadgarvirus/model/request_model.dart';
import 'package:madadgarvirus/model/user_model.dart';
import 'package:madadgarvirus/utils/app_constants.dart';

import 'model/worker_details_model.dart';

class FirebaseRepository {
  FirebaseRepository._();

  static FirebaseRepository instance = FirebaseRepository._();

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance;

  late final userCollection =
      _fireStore.collection(FirebaseConstants.userCollections);

  Future<void> postUserDetailsToFirestore(UserModel userModel) async {
    final user = _auth.currentUser;
    userModel.docId = user!.uid;
    await userCollection.doc(user.uid).set(userModel.toJson());
  }

  Future<UserModel> getCurrentUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var doc = await userCollection.doc(user!.uid).get();
    final data = doc.data();
    if (data != null && data.isNotEmpty) {
      return UserModel.fromJson(data)..docId = doc.id;
      //return doc.get('en').map((data) => data['0']).toList();
    } else {
      throw ('Document does not exist on the database');
    }
  }

  Future<UserModel> getAllDataFromSpecifiedUser(String userId) async {
    var doc = await userCollection.doc(userId).get();
    final data = doc.data();
    if (data != null && data.isNotEmpty) {
      final user = UserModel.fromJson(data);
      return user;
    } else {
      throw ('Document does not exist on the database');
    }
  }

  Future<UserModel> getUserDataFromId(
    String uid,
  ) async {
    final workerDoc = await userCollection.doc(uid).get();
    final Map<String, dynamic>? allData = workerDoc.data();
    if (allData != null) {
      final user = UserModel.fromJson(allData);
      return user;
    }
    throw ('Empty Data Found');
  }

  //
  // Future<Map<String, String>> getDataForUID(String uid) async {
  //   final DocumentSnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   final Map<String, dynamic> data = snapshot.data()! as Map;
  //   final String id = data['id'];
  //   final DocumentSnapshot snapshot2 =
  //       await FirebaseFirestore.instance.collection('users').doc(id).get();
  //   final Map<String, dynamic> data2 = snapshot2.data()!;
  //   final String name = data2['name'];
  //   final String role = data2['role'];
  //   final String city = data2['city'];
  //   final String state = data2['state'];
  //   final String country = data2['country'];
  //   final String phone = data2['phone'];
  //   final String dob = data2['dob'];
  //   final String profileimage = data2['profileimage'];
  //   final int age = data2['age'];
  //   final Map<String, String> result = {
  //     'name': name,
  //     'role': role,
  //     'city': city,
  //     'state': state,
  //     'country': country,
  //     'phone': phone,
  //     'dob': dob,
  //     'profileimage': profileimage,
  //     'age': age.toString(),
  //   };
  //   return result;
  // }

  Future<bool> isFarmerRoleRegistered() async {
    final user = await getCurrentUserData();
    return user.isFarmer;
  }

  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    final data =
        await userCollection.where('phone', isEqualTo: phoneNumber).get();
    return data.size > 0;
  }

  Future<String> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  Future<bool> alreadyRequestedToFarmer(String farmerDocId) async {
    final uid = await FirebaseRepository.instance.getCurrentUserId();
    final snapshot = await userCollection
        .doc(farmerDocId)
        .collection("requests")
        .where('id', isEqualTo: uid)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> alreadyAcceptedToFarmer(String farmerDocId) async {
    final uid = await FirebaseRepository.instance.getCurrentUserId();
    final snapshot = await userCollection
        .doc(uid)
        .collection("allowed")
        .where('id', isEqualTo: farmerDocId)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> alreadyApprovedToFarmer(String farmerDocId) async {
    final uid = await FirebaseRepository.instance.getCurrentUserId();
    final snapshot = await userCollection
        .doc(uid)
        .collection("approved")
        .where('id', isEqualTo: farmerDocId)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> removeFromAcceptedListOfFarmer(String farmerDocId) async {
    final uid = await FirebaseRepository.instance.getCurrentUserId();
    final allowColl = userCollection.doc(uid).collection("allowed");
    final snap = await allowColl.where('id', isEqualTo: farmerDocId).get();
    if (snap.docs.isNotEmpty) {
      final docId = snap.docs.first.id;
      await allowColl.doc(docId).delete();
    }

    final farmerColl = userCollection.doc(farmerDocId).collection('approved');
    final farmerSnap = await farmerColl.where('id', isEqualTo: uid).get();
    if (farmerSnap.docs.isNotEmpty) {
      final docId = farmerSnap.docs.first.id;
      await farmerColl.doc(docId).delete();
    }
  }

  Future<void> sendRequestToFarmer(String farmerDocId) async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    var doc = await userCollection.doc(uid).get();
    final data = doc.data();
    if (data != null && data.isNotEmpty) {
      final user = UserModel.fromJson(data);
      final reqModel = RequestModel(
        id: uid,
        profileImage: user.profileImage,
        nameEn: user.englishUserData.name,
        nameHi: user.hindiUserData.name,
        nameGuj: user.gujaratiUserData.name,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(farmerDocId)
          .collection("requests")
          .doc()
          .set(reqModel.toJson());
    }
  }

  Future<void> withdrawRequestToFarmer(String farmerDocId) async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    final reqColl = FirebaseFirestore.instance
        .collection('users')
        .doc(farmerDocId)
        .collection("requests");
    final snap = await reqColl.where('id', isEqualTo: uid).get();
    if (snap.docs.isNotEmpty) {
      final docId = snap.docs.first.id;
      await reqColl.doc(docId).delete();
    }
  }

  //TODO: Specified in - requests.dart
  getListOfWorkerIdForRequest() {}

  Future<void> rejectRequestFromTheWorker(String workerDocId) async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("requests")
        .doc(workerDocId)
        .delete();
  }

  Future<void> acceptWorkerRequest(String workerDocId) async {
    final userData = await FirebaseRepository.instance.getCurrentUserData();
    final currentUserDoc = userCollection.doc(userData.docId);
    final requestDataRef = await currentUserDoc
        .collection("requests")
        .where(
          'id',
          isEqualTo: workerDocId,
        )
        .get();
    final userDocs = requestDataRef.docs;
    if (userDocs.isNotEmpty && userDocs.first.exists) {
      final requestDataId = userDocs.first.id;
      final requestDataMap = userDocs.first.data();
      await currentUserDoc.collection('allowed').doc().set(requestDataMap);
      await currentUserDoc.collection("requests").doc(requestDataId).delete();
      final workerUserDoc = userCollection.doc(workerDocId);
      final userModel = RequestModel(
        id: userData.docId!,
        profileImage: userData.profileImage,
        nameEn: userData.englishUserData.name,
        nameHi: userData.hindiUserData.name,
        nameGuj: userData.gujaratiUserData.name,
      );
      await workerUserDoc.collection("approved").doc().set(
            userModel.toJson(),
          );
    }
  }

  Future<void> uploadNewJobOfFarmer(JobModel jobModel) async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    await userCollection.doc(uid).update(
      {'job': jobModel.toJson()},
    );
  }

  Future<void> uploadMoreDetailsOfWorker(
      WorkerDetailsModel detailsModel) async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    await userCollection.doc(uid).update(
      {'more_details': detailsModel.toJson()},
    );
  }

  Future<List<UserModel>> getAllFarmerList() async {
    final farmerQueryDocs = await userCollection
        .where(
          'en.role',
          isEqualTo: AppConstants.farmerRole,
        )
        .get();
    if (farmerQueryDocs.docs.isNotEmpty) {
      final farmersData = farmerQueryDocs.docs;
      return farmersData.map((e) => UserModel.fromJson(e.data())).toList();
    }
    return <UserModel>[];
  }
  //
  // Future<List<UserModel>> getApprovedListData() async {
  //   var uid = await FirebaseRepository.instance.getCurrentUserId();
  //   final usersRef = userCollection;
  //   final userDocSnapshot = await usersRef.doc().get();
  //
  //   final allowedSubcollectionRef = userDocSnapshot.reference.collection('allowed');
  //
  //   final allowedSubcollectionSnapshot = await allowedSubcollectionRef.get();
  //
  //   List<UserModel> userModelList = [];
  //
  //   for (final doc in allowedSubcollectionSnapshot.docs) {
  //     final userData = doc.data();
  //
  //     final userModel = UserModel.fromJson(userData);
  //     userModel.docId = doc.id;
  //
  //     userModelList.add(userModel);
  //   }
  //
  //   return userModelList;
  // }

  Future<void> deleteMoreDetail() async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    await userCollection.doc(uid).update(
      {'more_details': FieldValue.delete()},
    );
  }

  Future<void> deleteJob() async {
    var uid = await FirebaseRepository.instance.getCurrentUserId();
    await userCollection.doc(uid).update(
      {'job': FieldValue.delete()},
    );
  }
}
