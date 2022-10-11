import 'dart:ui';

import 'package:fitopatologia_app/view/components/infoItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProgressItem extends StatelessWidget {
  String? infoStep;
  List<dynamic>? infoCard;
  String? image;
  ProgressItem(
      {required this.infoStep,
      required this.infoCard,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoItem(
                  titulo: infoCard![0][0],
                  icone: infoCard![0][1],
                  info: infoCard![0][2],
                ),
                InfoItem(
                  titulo: infoCard![1][0],
                  icone: infoCard![1][1],
                  info: infoCard![1][2],
                ),
                InfoItem(
                  titulo: infoCard![2][0],
                  icone: infoCard![2][1],
                  info: infoCard![2][2],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(infoStep!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(1, 2.5), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(image: AssetImage(image!))),
            ),
          ],
        ),
      ),
    );
  }
}
