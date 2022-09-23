import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fitopatologia_app/model/news.model.dart';
import 'package:fitopatologia_app/view/components/anexoNetwork.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:fitopatologia_app/view/newsInformation.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (retorno == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Color.fromARGB(68, 76, 175, 79),
        ),
        body: Background(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Notícias",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
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
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Color.fromARGB(68, 76, 175, 79),
      ),
      body: Background(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Notícias",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                width: size.width,
                height: size.height * 0.802,
                child: ListView.separated(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsInformation()),
                          );
                        }),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              )),
        ],
      )),
    );
  }
}
