import 'package:capstoneapp/screens/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstoneapp/components/reusable_card.dart';
import 'package:capstoneapp/components/icon_content.dart';
import 'package:capstoneapp/components/bottom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:capstoneapp/components/alert_box.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:tflite/tflite.dart';

class FunctionalityScreen extends StatefulWidget {
  static const String id = 'functionality_screen';
  @override
  _FunctionalityScreenState createState() => _FunctionalityScreenState();
}

class _FunctionalityScreenState extends State<FunctionalityScreen> {
  //model

  void modelcall() async {
    String res = await Tflite.loadModel(
        model: "assets/models/pretrained_inceptionv3.tflite",
        // labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
    print('success');
  }

  final _auth = FirebaseAuth.instance;
  File _image;
  File _video;
  ChewieController chewieController;
  VideoPlayerController videoPlayerController1;

  Future getVideo() async {
    File video;
    video = await ImagePicker.pickVideo(source: ImageSource.camera);
    videoPlayerController1 = VideoPlayerController.file(video);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController1,
      autoPlay: true,
      looping: true,
      aspectRatio: 0.8,
    );
    setState(() {
      _video = video;
      _image = null;
    });
  }

  @override
  void dispose() {
    videoPlayerController1.dispose();
    chewieController.dispose();
    super.dispose();
  }

  Future getImage(int isCamera) async {
    File image;
    if (isCamera == 1) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else if (isCamera == 2) {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
      _video = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAPTION GENERATOR'),
        backgroundColor: Color(0xFF0A0E21),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      backgroundColor: Color(0xFF0A0E21),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      getImage(1);
                    },
                    cardChild: IconContent(
                        label: 'CAMERA', icon: FontAwesomeIcons.camera),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      getVideo();
                    },
                    cardChild: IconContent(
                        label: 'VIDEO', icon: FontAwesomeIcons.video),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      getImage(2);
                    },
                    cardChild: IconContent(
                        label: 'UPLOAD FROM GALLERY',
                        icon: FontAwesomeIcons.upload),
                  ),
                ),
                _video != null
                    ? Expanded(
                        child: ReusableCard(
                          cardChild: Chewie(controller: chewieController),
                        ),
                      )
                    : _image == null
                        ? Expanded(
                            child: ReusableCard(
                              cardChild: Text(
                                'NO IMAGE OR VIDEO SELECTED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ReusableCard(
                              cardChild: Image.file(_image),
                            ),
                          )
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'GET CAPTION',
            onTap: () {
              if (_image == null && _video == null)
                showDialog(
                  context: context,
                  builder: (_) => AlertBox('ERROR', 'No media selected'),
                  barrierDismissible: false,
                );
              //made changes here
              else
                //Navigator.pushNamed(context, ResultPage.id);
                modelcall();
            },
          )
        ],
      ),
    );
  }
}
