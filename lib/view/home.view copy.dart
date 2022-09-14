import 'dart:io';
import 'dart:convert';
import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/view/cadastro.view.dart';
import 'package:fitopatologia_app/view/history.view.dart';
import 'package:fitopatologia_app/view/login.view.dart';
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

class HomePage2 extends StatefulWidget {
  File? teste;
  HomePage2({Key? key, this.teste}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  int currentTab = 0;

  final List<Widget> screens = [
    LoginView(),
    CadastroView(),
    LoginView(),
    HistoryPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = LoginView();

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
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      setState(() {
                        currentScreen = LoginView();
                        currentTab = 0;
                      });
                    }, 
                  ),
                  IconButton(
                    icon: const Icon(Icons.newspaper),
                    onPressed: () {
                      setState(() {
                        currentScreen = CadastroView();
                        currentTab = 1;
                      });
                    }, 
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      setState(() {
                        currentScreen = LoginView();
                        currentTab = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      /*Navigator.push(
                        context, // error
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HistoryPage();
                          },
                        ),
                      );*/
                      currentScreen = HistoryPage();
                      currentTab = 3;
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
