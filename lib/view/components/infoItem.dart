import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoItem extends StatelessWidget {
  String titulo;
  String info;
  IconData icone;
  InfoItem(
      {required this.titulo,
      required this.icone,
      required this.info,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: size.width * 0.3,
        height: size.height * 0.13,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(1, 2.5), // changes position of shadow
              ),
            ],
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                titulo,
                style: TextStyle(
                    fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
              ),
              Icon(
                icone,
                size: size.width * 0.05,
              ),
              Text(info, style: TextStyle(fontSize: size.width * 0.04)),
            ],
          ),
        ),
      ),
    );
  }
}
