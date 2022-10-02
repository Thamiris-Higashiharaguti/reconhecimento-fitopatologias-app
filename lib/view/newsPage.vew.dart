import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fitopatologia_app/model/news.model.dart';
import 'package:fitopatologia_app/view/components/anexoNetwork.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:fitopatologia_app/view/newsInformation.view.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retorno = null;
    getArticle();
  }

  final controller = ScrollController();
  late List<dynamic>? retorno;
  final endPointUrl = Uri.parse(
      'https://newsapi.org/v2/everything?q=Citrus&sortBy=popularity&apiKey=93e154c7017c49aca3b5e97c6cc3b7c8');

  void getArticle() async {
    var res = await http.get(endPointUrl);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      print(json['articles']);
      setState(() {
        retorno = json['articles'];
      });
    } else {
      throw ("Can't get the Articles");
    }
  }

  void openURL(String UrlNoticia) async {
    final Uri _url = Uri.parse(UrlNoticia);
    try {
      await launchUrl(_url);
    } finally {
      print('Foi não');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (retorno == null) {
      return Scaffold(
        appBar: ScrollAppBar(
          controller: controller,
          automaticallyImplyLeading: false, // Note the controller here
          centerTitle: true,
          title: Text(
            "Notícias",
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
        body: Background(
          child: Column(
            children: [
              Container(
                  width: size.width,
                  height: size.height * 0.802,
                  child: Center(
                      child: Container(
                          width: size.width * 0.1,
                          height: size.height * 0.05,
                          child: CircularProgressIndicator()))),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: ScrollAppBar(
        automaticallyImplyLeading: false,
        controller: controller, // Note the controller here
        centerTitle: true,
        title: Text(
          "Notícias",
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
      body: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Flexible(
                child: Container(
                  width: size.width,
                  height: size.height * 0.802,
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: controller,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: size.height * 0.05,
                      );
                    },
                    itemCount: retorno!.length,
                    itemBuilder: (context, index) {
                      try {
                        return InkWell(
                          onTap: (() {
                            openURL(
                              retorno![index]['url'],
                            );
                          }),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text(
                                  retorno![index]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AnexoNetwork(
                                      arquivo: retorno![index]['urlToImage']),
                                  Container(
                                    width: size.width * 0.4,
                                    height: size.height * 0.2,
                                    child: Text(
                                      retorno![index]['description'],
                                      textAlign: TextAlign.justify,
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      } catch (error) {
                        return Container();
                      }
                    },
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
