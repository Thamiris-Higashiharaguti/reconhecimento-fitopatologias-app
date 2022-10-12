import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnexoNetwork extends StatelessWidget {
  final String arquivo;
  const AnexoNetwork({Key? key, required this.arquivo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SizedBox(
            width: size.width * 0.4,
            height: size.height * 0.2,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Column(
                  children: [
                    CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: size.height * 0.2,
                        width: size.width * 0.4,
                        placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: size.width * 0.1,
                                height: size.height * 0.05,
                                child: new CircularProgressIndicator(),
                              ),
                            ),
                        // progressIndicatorBuilder:
                        //     (context, url, progress) {
                        //   return Container(
                        //       width: size.width * 0.05,
                        //       height: size.height * 0.05,
                        //       child:
                        //           CircularProgressIndicator(
                        //               value:
                        //                   progress.progress,
                        //               color: Colors.amber));
                        // },
                        imageUrl: arquivo)
                  ],
                ))),
      ),
    );
  }
}
