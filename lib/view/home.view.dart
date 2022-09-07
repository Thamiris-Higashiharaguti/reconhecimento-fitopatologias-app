import 'dart:io';
import 'dart:convert';
import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future createAlbum(File imagem) async {
    List<int> imageBytes = await imagem.readAsBytesSync();
    //String base64Image = base64Encode(imageBytes);
    print(imagem.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://8376-34-86-138-182.ngrok.io/imagem'));
    request.files.add(await http.MultipartFile.fromPath('imagem', imagem.path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    Map valueMap = json.decode(response.body);
    return valueMap;

    /*
    
    var filename = imagem.path.split('/').last;
    FormData formData = new FormData.fromMap({"imagem": imagem.path});
    var response = await Dio().post('http://192.168.163.248:4000/imagem',
        data: formData,
        options: Options(receiveTimeout: 500000, sendTimeout: 500000));
    print("base64Image");
    return response.data;*/
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
        buttonSize: Size(70, 70),
        spaceBetweenChildren: 20,
        spacing: 20,
        animatedIcon: AnimatedIcons.menu_close,
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
                //getFileFromGallery();
              }),
          SpeedDialChild(
              child: Icon(Icons.cloud),
              label: "Galeria Nuvem",
              labelStyle: TextStyle(color: Colors.white),
              labelBackgroundColor: Color.fromARGB(255, 121, 0, 169),
              onTap: () {})
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.newspaper)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
                ],
              ),
            )),
      ),
    );
  }
}
