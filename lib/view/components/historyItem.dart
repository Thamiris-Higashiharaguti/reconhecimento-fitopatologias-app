import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/view/previewPageNetwork.view.dart';
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
          color: Color.fromARGB(96, 29, 99, 1),
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
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.01,
              left: size.width * 0.02,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PreviewPageNetwork(photoLink: photoLink)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl: photoLink,
                        fit: BoxFit.cover,
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                        errorWidget: (context, url, error) => Container(
                          child: const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      )
                      /*Image.network(
                        photoLink,
                        fit: BoxFit.cover,
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                      )*/
                      ),
                ),
              ),
            ),
            Positioned(
                top: size.height * 0.025,
                left: size.width * 0.27,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Diagnostico: " + diag.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 236, 236, 236),
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text("Data: " + data.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 236, 236, 236),
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
