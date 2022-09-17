import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/model/diagnostico.model.dart';
import 'package:fitopatologia_app/view/components/anexo.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResultPage extends StatefulWidget {
  File? foto;
  final DiagnosticoModel modelPrimeiroDiag;
  final DiagnosticoModel modelSegundoDiag;
  ResultPage(
      {super.key,
      required this.foto,
      required this.modelPrimeiroDiag,
      required this.modelSegundoDiag});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  double total = 0;
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImages(widget.modelPrimeiroDiag.doenca!);
  }

  loadImages(String caminho) async {
    refs = (await storage.ref('example/${caminho}').listAll()).items;
    for (var ref in refs) {
      arquivos.add(await ref.getDownloadURL());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  child: Column(
                children: [
                  Container(
                    child: Background(
                      child: Container(),
                    ),
                    width: size.width,
                    height: size.height,
                  ),
                ],
              )),
              Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.85,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(188, 237, 253, 227),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                      ),
                    ],
                  )),
              Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Anexo(arquivo: widget.foto!),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        widget.modelPrimeiroDiag.doenca!,
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Positioned(
                  top: size.height * 0.35,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size.width * 0.9,
                        height: size.height * 0.35,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      widget.modelPrimeiroDiag.doenca!,
                                      style: TextStyle(
                                          fontSize: size.height * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 1,
                                      height: size.height * 0.2,
                                      child: ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                              width: size.width * 0.048);
                                        },
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        primary: true,
                                        itemCount: (arquivos.length),
                                        itemBuilder: (context, index) {
                                          print(arquivos);
                                          return ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              child: Image.network(
                                                arquivos[index],
                                                fit: BoxFit.cover,
                                                height: size.height * 0.03,
                                                width: size.width * 0.25,
                                              ));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(size.width * 0.9,
                                                    size.height * 0.05)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ler mais',
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Icon(
                                              Icons.arrow_circle_right_outlined)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
