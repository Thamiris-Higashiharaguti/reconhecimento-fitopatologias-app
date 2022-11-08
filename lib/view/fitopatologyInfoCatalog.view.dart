import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class FitopatolofyInfoCatalog extends StatefulWidget {
  List<String> doenca;
  FitopatolofyInfoCatalog({required this.doenca, super.key});

  @override
  State<FitopatolofyInfoCatalog> createState() =>
      _FitopatolofyInfoCatalogState();
}

class _FitopatolofyInfoCatalogState extends State<FitopatolofyInfoCatalog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // Note the controller here
        centerTitle: true,
        title: Text(
          widget.doenca[0],
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
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: CachedNetworkImage(
                          imageUrl: widget.doenca[3],
                          fit: BoxFit.cover,
                          height: size.height * 0.4,
                          width: size.width * 0.5,
                          placeholder: (context, url) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 50, 25, 50),
                              child: CircularProgressIndicator.adaptive(),
                            );
                          })),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: size.width * 0.04),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doenca[0],
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              child: Text(
                                widget.doenca[1],
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
                        widget.doenca[2],
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
