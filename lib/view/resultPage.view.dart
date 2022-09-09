import 'dart:io';
import 'package:fitopatologia_app/view/components/anexo.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResultPage extends StatefulWidget {
  File? foto;
  String? diagnostico;
  ResultPage({super.key, required this.foto, required this.diagnostico});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
                      child: Container(
                        child: Text('Saudavel'),
                      ),
                    ),
                    width: size.width * 0.9,
                    height: size.height,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              )),
              Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.75,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 94, 255, 0),
                            borderRadius: BorderRadius.circular(35)),
                      ),
                    ],
                  )),
              Positioned(
                  top: size.height * 0.2,
                  left: size.width * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Anexo(arquivo: widget.foto!),
                      Text(
                        widget.diagnostico!,
                        style: TextStyle(
                            fontSize: size.height * 0.04,
                            fontWeight: FontWeight.bold),
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
