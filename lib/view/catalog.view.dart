import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitopatologia_app/model/fitopatology.dart';
import 'package:fitopatologia_app/view/components/catalogItem.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class catalogFito extends StatefulWidget {
  const catalogFito({super.key});

  @override
  State<catalogFito> createState() => _catalogFitoState();
}

class _catalogFitoState extends State<catalogFito> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  List<Reference> refs = [];
  List<String> cancro = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = ScrollController();
    DiagnosticoModel diagModel = DiagnosticoModel();
    return Scaffold(
      appBar: ScrollAppBar(
        automaticallyImplyLeading: false,
        controller: controller, // Note the controller here
        centerTitle: true,
        title: Text(
          "Catálogo",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 10,
        actions: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 18, 0),
              width: size.width * 0.15,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context, // error
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProfileEditView();
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.person_outline,
                  color: Colors.black,
                ),
              )),
        ],

        backgroundColor: Color.fromARGB(68, 76, 175, 79),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02,
            left: size.width * 0.03,
            right: size.width * 0.03),
        child: ListView(
          controller: controller,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: CatalogItem(doenca: diagModel.cancro),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.03),
              child: CatalogItem(doenca: diagModel.manchaPreta),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.03),
              child: CatalogItem(doenca: diagModel.greening),
            ),
          ],
        ),
      ),
    );
  }
}
