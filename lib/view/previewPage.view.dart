import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/main.dart';
import 'package:fitopatologia_app/model/diagnostico.model.dart';
import 'package:fitopatologia_app/view/home.view.dart';
import 'package:fitopatologia_app/view/resultPage.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class PreviewPage extends StatefulWidget {
  File teste;
  PreviewPage({Key? key, required this.teste}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with SingleTickerProviderStateMixin {
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void createAlbum(File imagem) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://93e9-34-125-141-141.ngrok.io/imagem'));
    request.files.add(await http.MultipartFile.fromPath('imagem', imagem.path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Map valueMap = json.decode(response.body);
    Upload(valueMap['PrimeiroDiagnostico']['doenca']);
    if (mounted) {
      Navigator.push(
        context, // error
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ResultPage(
              foto: imagem,
              modelPrimeiroDiag: DiagnosticoModel(
                  valueMap['PrimeiroDiagnostico']['doenca'],
                  valueMap['PrimeiroDiagnostico']['descricao'],
                  double.parse(
                      valueMap['PrimeiroDiagnostico']['probabilidade'])),
              modelSegundoDiag: DiagnosticoModel(
                  valueMap['SegundoDiagnostico']['doenca'],
                  valueMap['SegundoDiagnostico']['descricao'],
                  double.parse(
                      valueMap['SegundoDiagnostico']['probabilidade'])),
            );
          },
        ),
      );
    }
  }

  void Upload(String diagnostico) async {
    try {
      DateTime date = DateTime.now();
      String ref = auth.currentUser!.uid + '/img-${date.toString()}.jpg';
      var response = await storage.ref(ref).putFile(widget.teste!);
      var refs = (await storage.ref(auth.currentUser!.uid).listAll()).items;
      var link = await refs.last.getDownloadURL();
      db.collection("diagnosticos").add({
        "data": Timestamp.fromDate(date.add(Duration(hours: 3))),
        "uid": auth.currentUser!.uid,
        "link": link,
        "diagnostico": diagnostico,
      });
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  bool uploading = false;
  late AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000))
    ..repeat(reverse: true);

  late Animation<Offset> _animationVertical =
      Tween(begin: Offset(0, -10), end: Offset(0, 10)).animate(_controller);
  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                  child: Image.file(
                widget.teste,
                fit: BoxFit.cover,
              )),
              if (uploading != true) ...[
                Container()
              ] else ...[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Analisando Imagem!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: SlideTransition(
                          position: _animationVertical,
                          child: Container(
                            width: size.width,
                            height: 50,
                            decoration: BoxDecoration(boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromARGB(136, 9, 255, 0),
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 0.75))
                            ], color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (uploading != true) ...[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 102, 255, 0),
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                uploading = true;
                                createAlbum(widget.teste!);
                              });

                              /*
                            Navigator.push(
                              context, // error
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomePage(teste: teste);
                                },
                              ),
                            );*/
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ] else ...[
                    Container()
                  ]
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
