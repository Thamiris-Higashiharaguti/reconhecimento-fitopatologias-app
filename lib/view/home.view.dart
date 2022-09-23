import 'dart:io';
import 'dart:convert';
import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/view/history.view.dart';
import 'package:fitopatologia_app/view/login.view.dart';
import 'package:fitopatologia_app/view/newsPage.vew.dart';
import 'package:fitopatologia_app/view/previewPage.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  File? teste;
  HomePage({Key? key, this.teste}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  final List<Widget> screens = [NewsPage(), HistoryPage()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = NewsPage();

  late File _image;
  late List _results;
  final FirebaseStorage storage = FirebaseStorage.instance;
  File? arquivo;
  List<CameraDescription> cameras = [];
  CameraController? controller;
  final picker = ImagePicker();
  bool uploading = false;
  double total = 0;
  bool controlador = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCameras();
  }

  loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException {
      print("Errou");
    }
  }

  _startCamera() async {
    if (cameras.isEmpty) {
      print("Camera não encontrada");
    } else {
      _previewCamera(cameras.first);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
        camera, ResolutionPreset.high,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
    controller = cameraController;
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print(e.description);
    }
    if (mounted) {
      setState(() {});
    }
  }

  showPreview(arquivo) async {
    File? arq = await Navigator.push(
      context, // error
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PreviewPage(teste: arquivo);
        },
      ),
    );
    if (arquivo != null) {
      setState(() {
        arquivo = arquivo;
        Navigator.pop(context);
      });
    }
  }

  void getFileFromGallery() async {
    final file = await picker.getImage(source: ImageSource.gallery);
    print(file!.path);
    Navigator.push(
      context, // error
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PreviewPage(teste: File(file.path));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),*/
          PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        buttonSize: Size(60, 60),
        spaceBetweenChildren: 20,
        spacing: 10,
        child: Icon(Icons.add_a_photo),
        backgroundColor: Color(0xFF3b8132),
        children: [
          SpeedDialChild(
              child: Icon(Icons.camera),
              label: "Camera",
              onTap: () {
                Navigator.push(
                  context, // error
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CameraCamera(
                          onFile: (arquivo) => showPreview(arquivo));
                    },
                  ),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.image),
              label: "Galeria",
              onTap: () {
                getFileFromGallery();
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Color(0xFF3b8132),
        child: IconTheme(
            data: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.newspaper),
                    onPressed: () {
                      setState(() {
                        currentScreen = NewsPage();
                        currentTab = 0;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () {
                      setState(() {
                        currentScreen = HistoryPage();
                        currentTab = 1;
                      });
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
