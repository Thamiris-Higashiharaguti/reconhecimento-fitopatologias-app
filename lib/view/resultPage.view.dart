import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/model/diagnostico.model.dart';
import 'package:fitopatologia_app/view/components/anexo.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:fitopatologia_app/view/components/diagInfo.dart';
import 'package:fitopatologia_app/view/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResultPage extends StatefulWidget {
  File foto;
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
  List<Reference> refs2 = [];
  List<String> arquivos2 = [];
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImages(
        widget.modelPrimeiroDiag.doenca!, widget.modelSegundoDiag.doenca!);
  }

  loadImages(String caminho1, String caminho2) async {
    refs = (await storage.ref('example/${caminho1}').listAll()).items;
    for (var ref in refs) {
      arquivos.add(await ref.getDownloadURL());
    }
    refs2 = (await storage.ref('example/${caminho2}').listAll()).items;
    for (var ref in refs2) {
      arquivos2.add(await ref.getDownloadURL());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var percent =
        (widget.modelPrimeiroDiag.probabilidade! * 100).toStringAsFixed(2);
    return Scaffold(
      body: ListView(
        shrinkWrap: false,
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
                    height: size.height * 0.26,
                  ),
                ],
              )),
              Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Anexo(arquivo: widget.foto),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            'Diagnostico: ',
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.modelPrimeiroDiag.doenca!,
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            'Probabilidade: ',
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            percent + "%",
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (double.parse(percent) == 100) ...[
                Text(
                  "Resultado:",
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ] else ...[
                Text(
                  "Possíveis Resultados",
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ],
              if (double.parse(percent) == 100) ...[
                DiagInfo(
                    arquivos: arquivos,
                    modelDiag: widget.modelPrimeiroDiag,
                    photoLink: widget.foto),
              ] else ...[
                DiagInfo(
                    arquivos: arquivos,
                    modelDiag: widget.modelPrimeiroDiag,
                    photoLink: widget.foto),
                DiagInfo(
                    arquivos: arquivos2,
                    modelDiag: widget.modelSegundoDiag,
                    photoLink: widget.foto),
              ],
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(157, 255, 61, 47)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, // error
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomePage();
                            },
                          ),
                        );
                      },
                      child: Text("FECHAR")),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
