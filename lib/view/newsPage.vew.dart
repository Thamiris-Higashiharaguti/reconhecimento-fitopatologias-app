import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fitopatologia_app/model/news.model.dart';
import 'package:fitopatologia_app/view/components/background.dart';
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
    retorno = [];
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
    return Scaffold(
      body: Background(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: size.height * 0.01,
                  );
                },
                itemCount: retorno!.length,
                itemBuilder: (context, index) {
                  try {
                    return Container(
                      width: size.width * 0.7,
                      height: size.height * 0.37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 238, 238, 238),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            SizedBox(
                                width: size.width * 0.7,
                                height: size.height * 0.35,
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                        width: size.width * 0.7,
                                        height: size.height * 0.2,
                                        progressIndicatorBuilder:
                                            (context, url, progress) {
                                          return CircularProgressIndicator
                                              .adaptive();
                                        },
                                        imageUrl: retorno![index]
                                            ['urlToImage']),
                                    Text(
                                      retorno![index]['title'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Text(
                                      retorno![index]['description'],
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  } catch (error) {
                    return Container();
                  }
                },
              ))),
    );
  }
}
