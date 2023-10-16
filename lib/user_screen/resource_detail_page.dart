import 'dart:async';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:madadgarvirus/utils/extension.dart';

import '../utils/app_constants.dart';
import '../utils/loading_widget.dart';

class ResouceDetailPage extends StatefulWidget {
  final List<String>? snapshot;
  final DocumentSnapshot document;
  final String? languageCode;

  const ResouceDetailPage(
      {super.key,
      required this.snapshot,
      required this.document,
      required this.languageCode});
  @override
  State<ResouceDetailPage> createState() => _ResouceDetailPageState();
}

enum TtsState { playing, stopped, paused, continued }

class _ResouceDetailPageState extends State<ResouceDetailPage> {
  // FlutterTts flutterTts = FlutterTts();
  //
  // TtsState ttsState = TtsState.stopped;
  //
  // void textToSpeech(String text) async {
  //   //ttsState = TtsState.playing;
  //   print(await flutterTts.getLanguages);
  //   await flutterTts.setLanguage("en-Us");
  //   await flutterTts.setVolume(0.5);
  //   await flutterTts.setSpeechRate(0.5);
  //   await flutterTts.setPitch(1);
  //   await flutterTts.speak(text);
  //   // ttsState = TtsState.stopped;
  // }
  //
  // void pausedSpeech() async {
  //   await flutterTts.pause();
  //   //ttsState = TtsState.paused;
  // }
  //
  // void stopSpeech() async {
  //   await flutterTts.stop();
  //   //ttsState = TtsState.stopped;
  // }

  late String? title;
  late String? description;
  late FlutterTts flutterTts;
  late String _newVoiceText;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState ttsState = TtsState.stopped;

  // get isPlaying => ttsState == TtsState.playing;
  // get isStopped => ttsState == TtsState.stopped;
  // get isPaused => ttsState == TtsState.paused;
  // get isContinued => ttsState == TtsState.continued;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  @override
  initState() {
    super.initState();
    title = widget.snapshot!.first;
    description = widget.snapshot!.last;
    _newVoiceText = title! + description!;
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedLoadingWidget(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: kDarkColor,
              expandedHeight: 200,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  width: double.maxFinite,
                  height: context.height20,
                  //padding: const EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.radius50),
                      topRight: Radius.circular(context.radius50),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.document['imageURL'],
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.height20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        title = widget.snapshot!.first,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: context.height45,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        description = widget.snapshot!.last,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                          height: 1.5,
                          wordSpacing: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.height20,
                    ),
                    // widget.languageCode == 'en'
                    //     ? SizedBox(
                    //         width: double.infinity,
                    //         height: MediaQuery.of(context).size.height * 0.05,
                    //         child: ElevatedButton(
                    //           onPressed: () async {
                    //             await TextToSpeech.speakTitle(
                    //                 widget.snapshot!.first);
                    //             await TextToSpeech.speakDescription(
                    //                 widget.snapshot!.last);
                    //           },
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: kDarkColor,
                    //             textStyle: const TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           child: const Text(
                    //             'Listen This Article',
                    //             style: TextStyle(
                    //                 fontSize: 14.0,
                    //                 fontWeight: FontWeight.normal),
                    //           ),
                    //         ),
                    //       )
                    //     : Container(),
                    // SizedBox(
                    //   height: context.height45,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     SizedBox(
                    //       // width: double.infinity,
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       child: ElevatedButton(
                    //         onPressed: () async => TextToSpeech.pause(),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: kDarkColor,
                    //           textStyle: const TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         child: const Text(
                    //           'Pause',
                    //           style: TextStyle(
                    //               fontSize: 14.0,
                    //               fontWeight: FontWeight.normal),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: context.width20,
                    //     ),
                    //     SizedBox(
                    //       //width: double.infinity,
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       child: ElevatedButton(
                    //         onPressed: () async => TextToSpeech.stop(),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: kDarkColor,
                    //           textStyle: const TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         child: const Text(
                    //           'Stop',
                    //           style: TextStyle(
                    //               fontSize: 14.0,
                    //               fontWeight: FontWeight.normal),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: context.height45,
                    // ),
                    _btnSection(),
                    SizedBox(
                      height: context.height45,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnSection() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
              'PLAY', _speak),
          _buildButtonColumn(
              Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
          _buildButtonColumn(
              Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(icon),
            color: color,
            splashColor: splashColor,
            onPressed: () => func()),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }
}
