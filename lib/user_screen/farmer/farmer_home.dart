import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/user_screen/farmer/worker_detail_screen.dart';

import '../../model/user_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/helper.dart';
import '../profile/language_preference.dart';
import 'farmer_search_filter.dart';

class FarmerHome extends StatefulWidget {
  const FarmerHome({super.key});

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  // final TextEditingController dateController = TextEditingController();
  String? langCode;

  @override
  void initState() {
    super.initState();
    langCode = LanguagePreference.getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(str.farmer),
        backgroundColor: kDarkerColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FarmerSearchFilterScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where(
              'en.role',
              isNotEqualTo: AppConstants.farmerRole,
            )
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
          final items = (snapshot.data!).docs;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 18,
            ),
            itemBuilder: (context, index) {
              final userModel = UserModel.fromJson(
                items[index].data() as Map<String, dynamic>,
              );
              final userDataModel = userModel.getUserDataModelFromCode(
                langCode: langCode,
              );
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
                  leading: userModel.profileImage == null
                      ? null
                      : CircleAvatar(
                          backgroundImage: NetworkImage(userModel.profileImage),
                          radius: 40,
                        ),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            //document['name'],
                            userDataModel.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text(document['city'] + ', ' + document['state']),
                          // Text(document['country']),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 0,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerDetailsScreen(
                          userModel: userModel,
                          userDataModel: userDataModel,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      //TODO: what to be shown in body ?
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('users')
      //       .where('role', isEqualTo: 'Worker')
      //       .snapshots(),
      //   builder:
      //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: const CircularProgressIndicator(),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Text("Loading");
      //     }
      //     return ListView.separated(
      //       padding: const EdgeInsets.all(8),
      //       itemCount: (snapshot.data! as QuerySnapshot).docs.length,
      //       separatorBuilder: (BuildContext context, int index) =>
      //           const SizedBox(
      //         height: 15,
      //       ),
      //       itemBuilder: (context, index) {
      //         DocumentSnapshot document =
      //             (snapshot.data! as QuerySnapshot).docs[index];
      //         // final user = Userm
      //         Color color = Colors.grey.shade200;
      //         return Container(
      //           color: color,
      //           height: 100,
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage: NetworkImage(document['profileimage']),
      //               radius: 40,
      //             ),
      //             title: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   document['name'],
      //                   style: const TextStyle(fontWeight: FontWeight.bold),
      //                 ),
      //                 Text(document['city'] + ', ' + document['state']),
      //                 Text(document['country']),
      //               ],
      //             ),
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) =>
      //                       UserDetailsScreen(document: document),
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
// body: Container(
//   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//   margin: EdgeInsets.all(14),
//   height: displayHeight(context) * 0.45 -
//       MediaQuery.of(context).padding.top -
//       kToolbarHeight,
//   width: displayWidth(context),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(15),
//     color: kLighterColor,
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'name :',
//         style: TextStyle(
//           fontSize: 20,
//           height: 2,
//         ),
//       ),
//       Text(
//         'role :',
//         style: TextStyle(
//           fontSize: 20,
//           height: 2,
//         ),
//       ),
//       Text(
//         'age :',
//         style: TextStyle(
//           fontSize: 20,
//           height: 2,
//         ),
//       ),
//       Text(
//         'state :',
//         style: TextStyle(
//           fontSize: 20,
//           height: 2,
//         ),
//       ),
//       Text(
//         'city :',
//         style: TextStyle(
//           fontSize: 20,
//           height: 2,
//         ),
//       ),
//     ],
//   ),
// ),
