import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/main.dart';
import 'package:fitopatologia_app/view/home.view.dart';
import 'package:fitopatologia_app/view/resultPage.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class PreviewPageNetwork extends StatefulWidget {
  String photoLink;
  PreviewPageNetwork({Key? key, required this.photoLink}) : super(key: key);

  @override
  State<PreviewPageNetwork> createState() => _PreviewPageNetworkState();
}

class _PreviewPageNetworkState extends State<PreviewPageNetwork> {
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
                  child: CachedNetworkImage(
                imageUrl: widget.photoLink,
                fit: BoxFit.contain,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
