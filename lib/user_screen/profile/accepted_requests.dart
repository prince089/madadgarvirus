import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/firebase_repository.dart';
import 'package:madadgarvirus/model/request_model.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/helper.dart';

class AcceptedRequests extends StatefulWidget {
  const AcceptedRequests({Key? key}) : super(key: key);

  @override
  State<AcceptedRequests> createState() => _AcceptedRequestsState();
}

class _AcceptedRequestsState extends State<AcceptedRequests> {
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(str.acceptedRequests),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
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
          //TODO:Null is subtype of Map<String,dynamic>
          final requestListDocs = snapshot.data?.docs;
          if (requestListDocs == null || requestListDocs.isEmpty) {
            return const Center(
              child: Text("No Request Found!!"),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: requestListDocs.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
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
      ),
    );
  }

  Future<void> getCurrentUid() async {
    uid = await FirebaseRepository.instance.getCurrentUserId();
    setState(() {});
  }
}
