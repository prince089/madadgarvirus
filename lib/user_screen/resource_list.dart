import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/user_screen/profile/language_preference.dart';
import 'package:madadgarvirus/user_screen/resource_detail_page.dart';

import '../utils/app_constants.dart';
import '../utils/helper.dart';
import '../utils/translator_helper.dart';

class ResourceList extends StatefulWidget {
  const ResourceList({Key? key}) : super(key: key);

  @override
  State<ResourceList> createState() => _ResourceListState();
}

class _ResourceListState extends State<ResourceList> {
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
        title: Text(str.worker),
        backgroundColor: kDarkerColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('resources').snapshots(),
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 18,
            ),
            itemBuilder: (context, index) {
              DocumentSnapshot document = (snapshot.data!).docs[index];
              // Future<List<String>> translatedStrings = translateDocument(
              //     document['title'], document['description']);
              return FutureBuilder(
                future: translateDocument(
                    document['title'], document['description']),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        //height: 100,
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
                        child: Column(
                          children: [
                            Image.network(
                              document['imageURL'],
                              height: 180.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                snapshot.data?.first as String,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.6,
                                  height: 1.5,
                                  wordSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResouceDetailPage(
                                snapshot: snapshot.data,
                                document: document,
                                languageCode: langCode),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text(str.loading));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> translateDocument(
      String title, String description) async {
    List<String> documentData = [
      title,
      description,
    ];

    List<String> translatedData = await TranslatorHelper.instance.fromList(
      data: documentData,
      code: langCode!,
    );

    return translatedData;
  }

  Future<String> translateString(String string) async {
    var translatedData = await TranslatorHelper.instance.fromString(
      text: string,
      code: langCode!,
    );

    return translatedData;
  }
}
