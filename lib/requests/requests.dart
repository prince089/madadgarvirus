import 'package:flutter/material.dart';
import 'package:madadgarvirus/requests/accepted_requests.dart';
import 'package:madadgarvirus/requests/pending_requests.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';

class Requests extends StatelessWidget {
  Requests({super.key});

  List<Tab> tabs = [
    Tab(child: Text(str.pendingRequests)),
    Tab(child: Text(str.acceptedRequests)),
  ];

  List<Widget> content = [
    const PendingRequests(),
    const AcceptedRequests(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(str.requests),
          backgroundColor: kDarkerColor,
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Colors.white,
            isScrollable: false,
          ),
        ),
        body: TabBarView(
          children: content,
        ),
      ),
    );
  }
}

// class RequestButton extends StatelessWidget {
//   final String title;
//   final bool isActive;
//   final VoidCallback press;
//   const RequestButton({
//     Key? key,
//     required this.title,
//     this.isActive = false,
//     required this.press,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: isActive
//                   ? const TextStyle(
//                       color: kDarkColor, fontWeight: FontWeight.bold)
//                   : const TextStyle(fontSize: 12),
//             ),
//             if (isActive)
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5),
//                 height: 3,
//                 width: 22,
//                 decoration: BoxDecoration(
//                   color: kDarkerColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
