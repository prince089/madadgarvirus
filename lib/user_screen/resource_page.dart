import 'package:flutter/material.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/extension.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            backgroundColor: kDarkColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/GreenGradient.jpg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.radius20),
                    topRight: Radius.circular(context.radius20),
                  ),
                ),
                child: const Center(
                  child: Text('Heyy There !!!!'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Sound water and land management plans are an important part of any farm operation. The Natural Resource Conservation Service (NRCS) is working with farmers and ranchers of all sizes to develop land and water management plans.  In addition, NRCS's Seasonal High Tunnel Initiative continues to extend the growing season and revenue opportunities while also promoting conservation for small and mid-sized farmers. The cost share program for high tunnels, also called hoop houses, started as a pilot in 2010. Since then, over 10,000 high tunnels have been contracted through NRCS. Sound water and land management plans are an important part of any farm operation. The Natural Resource Conservation Service (NRCS) is working with farmers and ranchers of all sizes to develop land and water management plans.  In addition, NRCS's Seasonal High Tunnel Initiative continues to extend the growing season and revenue opportunities while also promoting conservation for small and mid-sized farmers. The cost share program for high tunnels, also called hoop houses, started as a pilot in 2010. Since then, over 10,000 high tunnels have been contracted through NRCS. Sound water and land management plans are an important part of any farm operation. The Natural Resource Conservation Service (NRCS) is working with farmers and ranchers of all sizes to develop land and water management plans.  In addition, NRCS's Seasonal High Tunnel Initiative continues to extend the growing season and revenue opportunities while also promoting conservation for small and mid-sized farmers. The cost share program for high tunnels, also called hoop houses, started as a pilot in 2010. Since then, over 10,000 high tunnels have been contracted through NRCS. Sound water and land management plans are an important part of any farm operation. The Natural Resource Conservation Service (NRCS) is working with farmers and ranchers of all sizes to develop land and water management plans.  In addition, NRCS's Seasonal High Tunnel Initiative continues to extend the growing season and revenue opportunities while also promoting conservation for small and mid-sized farmers. The cost share program for high tunnels, also called hoop houses, started as a pilot in 2010. Since then, over 10,000 high tunnels have been contracted through NRCS.",
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Positioned(
    //         left: 0,
    //         right: 0,
    //         child: Container(
    //           width: double.maxFinite,
    //           height: Dimensions.personStackImage,
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               fit: BoxFit.cover,
    //               image: NetworkImage(
    //                   'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png'),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: Dimensions.height45,
    //         left: Dimensions.width20,
    //         child: Row(
    //           children: const [
    //             AppIcon(icon: Icons.arrow_back_ios),
    //           ],
    //         ),
    //       ),
    //       Positioned(
    //         left: 0,
    //         right: 0,
    //         top: Dimensions.personStackImage - 20,
    //         bottom: 0,
    //         child: Container(
    //           padding: EdgeInsets.only(
    //             left: Dimensions.width20,
    //             right: Dimensions.width20,
    //             top: Dimensions.height20,
    //           ),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               topRight: Radius.circular(Dimensions.radius20),
    //               topLeft: Radius.circular(Dimensions.radius20),
    //             ),
    //             color: Colors.grey,
    //           ),
    //           child: Column(
    //             children: [
    //               Text('hello'),
    //               SizedBox(
    //                 height: Dimensions.height20,
    //               ),
    //               Text('there !!'),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
