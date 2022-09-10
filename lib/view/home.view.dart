import 'dart:io';
import 'dart:convert';
import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/view/history.view.dart';
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
  late File _image;
  late List _results;
  final FirebaseStorage storage = FirebaseStorage.instance;
  File? arquivo;
  List<CameraDescription> cameras = [];
  CameraController? controller;
  final picker = ImagePicker();
  bool uploading = false;
  double total = 0;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        buttonSize: Size(60, 60),
        spaceBetweenChildren: 40,
        spacing: 20,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color.fromARGB(255, 0, 95, 3),
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
        color: Color.fromARGB(255, 0, 95, 3),
        child: IconTheme(
            data: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.newspaper)),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context, // error
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HistoryPage();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.image)),
                ],
              ),
            )),
      ),
    );
  }
}
