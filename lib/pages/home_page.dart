// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element, unused_field, unused_local_variable

import 'package:ai_voice_assistant/components/feature_box.dart';
import 'package:ai_voice_assistant/services/openai_service.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService _openAIService = OpenAIService();
  final flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  // we have initialized the plugin
  Future<void> initSpeechToText() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> _speak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // A P P   B A R
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BounceInDown(
          child: Text(
            "Gryffin",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, color: Colors.blueGrey[900]),
          ),
        ),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),

      // A C T I O N   B U T T O N
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[400],
        child: Icon(_speechToText.isListening ? Icons.stop : Icons.mic,
            color: Colors.white),
        // if has permission, then start listening
        // in already listening, then stop listening
        onPressed: () async {
          if (await _speechToText.hasPermission &&
              _speechToText.isNotListening) {
            await _startListening();
          } else if (_speechToText.isListening) {
            final speech = await _openAIService.isArtPromptAPI(lastWords);
            if (speech.contains('https')) {
              // its image url -> assign to generatedImageUrl
              generatedImageUrl = speech;
              generatedContent = '';
              setState(() {});
            } else {
              // its text -> assign to generatedContent
              generatedContent = speech;
              generatedImageUrl = '';
              setState(() {});
              await _speak(speech);
            }
            await _speak(speech);
            await _stopListening();
          } else {
            initSpeechToText();
          }
        },
        elevation: 0,
      ),

      // B O D Y
      body: SingleChildScrollView(
        child: Column(
          children: [
            // we use stack in order to stack the assitant png
            // on top of the circular colored container
            ZoomIn(
              child: Stack(
                children: [
                  // circular container
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 0), // adjust this later on
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // virtual assistant png
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 0),
                      height: 105,
                      width: 105,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // check later on, why the image is not getting shown
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/VirtualAssistant.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Chat Bubble
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 40)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey.shade900),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      generatedContent == null
                          ? "Where Knowledge Begings"
                          : generatedContent!,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(generatedImageUrl!)),
              ),

            FadeInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: Text(
                    "Here are few commands:",
                    style: GoogleFonts.inter(
                      fontSize: generatedContent == null ? 16 : 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
              ),
            ),

            // features list box
            // will be covered entirely while showing the responce
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(microseconds: 10),
                    child: FeatureBox(
                        // correct all the colors later on
                        color: const Color.fromARGB(255, 162, 222, 255),
                        headerText: "ChatGPT",
                        boxBodyText:
                            "Best way to get answers to your questions using ChatGPT"),
                  ),
                  const SizedBox(height: 15),
                  SlideInLeft(
                    delay: Duration(microseconds: 900),
                    child: FeatureBox(
                        color: const Color.fromARGB(255, 251, 192, 153),
                        headerText: "Dall-E",
                        boxBodyText:
                            "Get inspired and stay creative with your assistant powered by Dall-E"),
                  ),
                  const SizedBox(height: 15),
                  SlideInLeft(
                    delay: Duration(microseconds: 2000),
                    child: FeatureBox(
                        color: const Color.fromARGB(255, 181, 193, 254),
                        headerText: "Smart Voice Assistant",
                        boxBodyText:
                            "Get the best of both worlds with a voice assistant powered by ChatGPT & Dall-E"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
