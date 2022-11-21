import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/color.dart';
import 'package:fitopatologia_app/model/fitopatology.dart';
import 'package:fitopatologia_app/view/previewPageNetwork.view.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FitopatologyDiag extends StatefulWidget {
  String doenca;
  FitopatologyDiag({required this.doenca, super.key});

  @override
  State<FitopatologyDiag> createState() => _FitopatologyDiagState();
}

class _FitopatologyDiagState extends State<FitopatologyDiag> {
  List info = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = ScrollController();

    DiagnosticoModel diagModel = DiagnosticoModel();

    if (widget.doenca == "Cancro cítrico") {
      info = diagModel.cancro;
    } else if (widget.doenca == "Mancha Preta") {
      info = diagModel.manchaPreta;
      print(info);
    } else if (widget.doenca == "Greening") {
      info = diagModel.greening;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // Note the controller here
        centerTitle: true,
        title: Text(
          info[0],
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
        ],

        backgroundColor: Tema.appBarColor,
      ),
      body: ListView(
        controller: controller,
        children: [
          Container(
            width: size.width * 0.9,
            height: size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  OpenContainer(
                    transitionDuration: Duration(milliseconds: 250),
                    closedBuilder: (context, action) {
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return Padding(
                              padding: const EdgeInsets.all(25),
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                          imageUrl: info[3],
                          fit: BoxFit.cover,
                          height: size.height * 0.4,
                          width: size.width * 0.5,
                          errorWidget: (context, url, error) => Container(
                            child: const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return PreviewPageNetwork(photoLink: info[3]);
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: size.width * 0.04),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info[0],
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              child: Text(
                                info[1],
                                maxLines: 20,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
                color: Color.fromARGB(232, 0, 0, 0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    "Tratamteno",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Text(
                        info[2],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
