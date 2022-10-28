import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/view/compare.view.dart';
import 'package:fitopatologia_app/model/diagnostico.model.dart';
import 'package:fitopatologia_app/view/fitopatologyInfo.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DiagInfo extends StatefulWidget {
  List<String> arquivos;
  final DiagnosticoModel modelDiag;
  var photoLink;
  DiagInfo(
      {super.key,
      required this.photoLink,
      required this.arquivos,
      required this.modelDiag});

  @override
  State<DiagInfo> createState() => _DiagInfoState();
}

class _DiagInfoState extends State<DiagInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var percent = (widget.modelDiag.probabilidade! * 100).toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(70, 161, 255, 120),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.modelDiag.doenca! + " - ",
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
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      width: size.width * 1,
                      height: size.height * 0.2,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: size.width * 0.048);
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        primary: true,
                        itemCount: (widget.arquivos.length),
                        itemBuilder: (context, index) {
                          print(widget.arquivos);
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context, // error
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ComparePage(
                                        photoLink: widget.photoLink,
                                        arquivos: widget.arquivos);
                                  },
                                ),
                              );
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                child: CachedNetworkImage(
                                    imageUrl: widget.arquivos[index],
                                    fit: BoxFit.cover,
                                    height: size.height * 0.01,
                                    width: size.width * 0.25,
                                    placeholder: (context, url) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 50, 25, 50),
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    })),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            useSafeArea: true,
                            builder: (BuildContext context) => AlertDialog(
                                  title:
                                      Text(widget.modelDiag.doenca!.toString()),
                                  content: FitopatologyInfo(
                                    arquivos: widget.arquivos,
                                    modelDiag: widget.modelDiag,
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('FECHAR'),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(size.width * 0.9, size.height * 0.05)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ler mais',
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Icon(Icons.arrow_circle_right_outlined)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
