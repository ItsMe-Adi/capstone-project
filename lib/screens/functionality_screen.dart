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
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

class FunctionalityScreen extends StatefulWidget {
  static const String id = 'functionality_screen';
  @override
  _FunctionalityScreenState createState() => _FunctionalityScreenState();
}

class _FunctionalityScreenState extends State<FunctionalityScreen> {
  void getImagePredictions(File imageFile) async {
    print("Making connection");
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    print(length);
    var uri = Uri.parse("http://192.168.0.106:5000/image");

    print("connection established");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    print(response);
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print(respStr);
      Map valueMap = json.decode(respStr);

      setState(() {
        _video = _video;
        _image = _image;
        _output_caption = valueMap['caption'];
      });
    }
  }

  void getVideoPredictions(File videoFile) async {
    print("Making connection for video model");
    var stream =
    new http.ByteStream(DelegatingStream.typed(videoFile.openRead()));
    var length = await videoFile.length();
    print(length);
    var uri = Uri.parse("http://192.168.0.106:5000/video");

    print("Connection established");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(videoFile.path));

    request.files.add(multipartFile);
    var response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print(respStr);
      Map valueMap = json.decode(respStr);

      print(valueMap["caption"]);
      setState(() {
        _video = _video;
        _image = _image;
        _output_caption = valueMap['caption'];
      });
    }
  }

  final _auth = FirebaseAuth.instance;
  File _image;
  File _video;
  String _output_caption;

  //ChewieController chewieController;
  //VideoPlayerController videoPlayerController1;

  Future getVideo(int isVideo) async {
    File video;
    if (isVideo == 3) {
      video = await ImagePicker.pickVideo(source: ImageSource.camera);
    } else if (isVideo == 4) {
      video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    }
    setState(() {
      _video = video;
      _image = null;
      _output_caption = null;
    });
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
      _output_caption = null;
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
                      getVideo(3);
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
                        label: 'UPLOAD IMAGE FROM GALLERY',
                        icon: FontAwesomeIcons.upload),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      getVideo(4);
                    },
                    cardChild: IconContent(
                        label: 'UPLOAD VIDEO FROM GALLERY',
                        icon: FontAwesomeIcons.upload),
                  ),
                ),
                _video != null
                    ? Expanded(
                  child: ReusableCard(
                    cardChild: /*Chewie(controller: chewieController)*/
                    Text(
                      'VIDEO SELECTED',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 22.5,
                      ),
                    ),
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
                        fontSize: 22.5,
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
          Expanded(
            child: Row(
              children: <Widget>[
                _output_caption != null
                    ? Expanded(
                  child: ReusableCard(
                      cardChild: Text(
                        _output_caption,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 35.0,
                        ),
                      )),
                )
                    : Expanded(
                  child: ReusableCard(
                    cardChild: Text(
                      'No output',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                      ),
                    ),
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
              else if (_image != null) {
                getImagePredictions(_image);
              } else if (_video != null) {
                getVideoPredictions(_video);
              }
            },
          )
        ],
      ),
    );
  }
}