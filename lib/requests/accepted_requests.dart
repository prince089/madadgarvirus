import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/request_model.dart';

import '../user_screen/farmer/worker_detail_screen.dart';
import '../user_screen/worker/farmer_detail_screen.dart';

class AcceptedRequests extends StatefulWidget {
  const AcceptedRequests({super.key});

  @override
  State<AcceptedRequests> createState() => _AcceptedRequestsState();
}

class _AcceptedRequestsState extends State<AcceptedRequests> {
  String? langCode;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('allowed')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        final requestListDocs = snapshot.data?.docs;
        if (requestListDocs == null || requestListDocs.isEmpty) {
          return const Center(
            child: Text("No Request Found!!"),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: requestListDocs.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 15,
          ),
          itemBuilder: (context, index) {
            final requestDoc =
                requestListDocs[index].data() as Map<String, dynamic>;
            final requestModel = RequestModel.fromJson(requestDoc);
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
                  backgroundImage: NetworkImage(requestModel.profileImage),
                  radius: 40,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      requestModel.getName(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  checkRole(requestModel.id);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         UserDetailsScreen(document: document),
                  //   ),
                  // );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> checkRole(String requesterId) async {
    final userDataFuture =
        FirebaseRepository.instance.getUserDataFromId(requesterId);
    final userModel = await userDataFuture;
    final isFarmer = userModel.isFarmer;
    final userDataModel = userModel.getUserDataModelFromCode(
      langCode: langCode,
    );
    isFarmer
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FarmerDetailsScreen(
                userModel: userModel,
                userDataModel: userDataModel,
              ),
            ),
          )
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerDetailsScreen(
                userModel: userModel,
                userDataModel: userDataModel,
              ),
            ),
          );
  }
}
