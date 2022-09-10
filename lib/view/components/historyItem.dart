import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HistoryItem extends StatelessWidget {
  String diag;
  String photoLink;
  var data;
  HistoryItem(
      {Key? key,
      required this.diag,
      required this.photoLink,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        height: size.height * 0.12,
        width: size.width * 0.2,
        decoration: BoxDecoration(
          color: Color.fromARGB(151, 29, 99, 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Image.network(
                        photoLink,
                        fit: BoxFit.cover,
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      diag,
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(data.toString(),
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.bold))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
