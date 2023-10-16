import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/request_model.dart';
import 'package:madadgarvirus/user_screen/farmer/worker_detail_screen.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/user_screen/worker/farmer_detail_screen.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({super.key});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('requests')
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
            final document =
                requestListDocs[index].data() as Map<String, dynamic>;
            final requestModel = RequestModel.fromJson(document);
            Color color = Colors.grey.shade200;
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
                    //   Text('${allDocument?.city}, ${allDocument?.state}'),
                    //   Text('${allDocument?.country}'),
                  ],
                ),
                onTap: () => checkRole(requestModel.id),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> checkRole(String requesterId) async {
    final userModel =
        await FirebaseRepository.instance.getUserDataFromId(requesterId);
    final isFarmer = userModel.isFarmer;
    final langCode = LanguagePreference.getLanguage();
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
                isFromPendingScreen: true,
              ),
            ),
          )
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerDetailsScreen(
                userModel: userModel,
                userDataModel: userDataModel,
                isFromPendingScreen: true,
              ),
            ),
          );
  }
}
