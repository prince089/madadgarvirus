import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopop/neopop.dart';
import 'package:translator/translator.dart';

class Extra extends StatefulWidget {
  const Extra({Key? key}) : super(key: key);

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  var engText = "";
  var hindiText = "";
  var gujaratiText = "";

  final TextEditingController inputTextController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();

  void translateIntoHindi() {
    translator.translate(inputTextController.text, to: "hi").then((result) {
      hindiText = result.text;
      setState(() {});
    });
  }

  void translateIntoGujarati() {
    translator.translate(inputTextController.text, to: "gu").then((result) {
      gujaratiText = result.text;
      setState(() {});
    });
  }

  void translateIntoEnglish() {
    translator.translate(inputTextController.text, to: "en").then((result) {
      engText = result.text;
      setState(() {});
    });
  }

  //add images module
  String _imageUrl = '';

  // from here
  File? _image;
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _uploadImageToFirebase();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _uploadImageToFirebase() async {
    setState(() {
      _isUploading = true;
    });
    final storage = FirebaseStorage.instance;
    //final fileName = 'avatar.jpg';
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = storage.ref().child('profileImages/$uniqueFileName');
    final task = ref.putFile(_image!);
    try {
      await task;
      _imageUrl = await ref.getDownloadURL();
      debugPrint(_imageUrl);
      setState(() {
        _isUploading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(str.extra),
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
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _isUploading
                        ? const CircularProgressIndicator()
                        : _image == null
                            ? const Center(
                                child: CircleAvatar(
                                  backgroundColor: kDarkColor,
                                  radius: 45,
                                  backgroundImage:
                                      AssetImage('assets/profileavtar.png'),
                                ),
                              )
                            : null,
                  ),
                ),
                TextFormField(
                  controller: inputTextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter string',
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                      left: 14.0,
                      bottom: 8.0,
                      top: 15.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: kDarkColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: kDarkColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "String cannot be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: NeoPopButton(
                    bottomShadowColor: kDarkerColor,
                    rightShadowColor: kDarkerColor,
                    color: kLightColor,
                    onTapUp: () {
                      HapticFeedback.vibrate();
                      translateIntoHindi();
                      translateIntoGujarati();
                      translateIntoEnglish();
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Translate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     translateIntoHindi();
                //     translateIntoGujarati();
                //     translateIntoEnglish();
                //   },
                //   child: const Text('Translate'),
                // ),
                Text(
                  hindiText,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  gujaratiText,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  engText,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Wrap the keyboard with Container to set background color.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
