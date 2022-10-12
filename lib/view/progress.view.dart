import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:fitopatologia_app/view/components/progressItem.dart';
import 'package:fitopatologia_app/view/history.view.dart';
import 'package:fitopatologia_app/view/login.view.dart';
import 'package:fitopatologia_app/view/newsInformation.view.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_view_indicator_ns/page_view_indicator_ns.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  var paginaAtual = 0.obs;
  var controller = PageController();
  Color _color1 = Color.fromARGB(255, 0, 0, 0);
  Color _color2 = Color.fromARGB(255, 0, 0, 0);
  Color _color3 = Color.fromARGB(255, 0, 0, 0);
  final pageIndexNotifier = ValueNotifier<int>(0);

  dynamic pagina;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: paginaAtual.value);
  }

  @override
  Widget build(BuildContext context) {
    print("Recarregou a pagina toda");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // // Note the controller here
        centerTitle: true,
        title: Text(
          "Informativo",
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
      extendBodyBehindAppBar: false,
      body: Background(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(onPressed: (() {
                      controller.animateToPage(0,
                          duration: Duration(milliseconds: 10),
                          curve: Curves.easeInCirc);
                    }), icon: Obx(
                      () {
                        return ImageIcon(
                          color: paginaAtual.value == 0
                              ? Colors.green
                              : Colors.black,
                          AssetImage('assets/icons/semente.png'),
                          size: 50,
                        );
                      },
                    )),
                    Text("Germinação")
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (() {
                      controller.animateToPage(1,
                          duration: Duration(milliseconds: 10),
                          curve: Curves.easeInCirc);
                    }), icon: Obx(
                      () {
                        return ImageIcon(
                          color: paginaAtual.value == 1
                              ? Colors.green
                              : Colors.black,
                          AssetImage('assets/icons/broto.png'),
                          size: 50,
                        );
                      },
                    )),
                    Text("Muda")
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (() {
                      controller.animateToPage(2,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInCirc);
                    }), icon: Obx(
                      () {
                        return ImageIcon(
                          color: paginaAtual.value == 2
                              ? Colors.green
                              : Colors.black,
                          AssetImage('assets/icons/laranjeira.png'),
                          size: 50,
                        );
                      },
                    )),
                    Text("Produção")
                  ],
                )
              ],
            ),
            Container(
              width: size.width,
              height: size.height * 0.8,
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  print(value);

                  paginaAtual.value = value;
                },
                children: [
                  ProgressItem(
                    infoStep:
                        "A germinação da semente da laranja ocorre entre 15-30 dias após a semeadura.",
                    infoCard: [
                      ["Temperatura", Icons.sunny, "20º a 32ºC"],
                      ["umidade", Icons.water_drop_rounded, "70% a 90%"],
                      ["altura", Icons.height_outlined, "1.10 a 1.50cm"],
                    ],
                    image: 'assets/germinacao.jpg',
                  ),
                  ProgressItem(
                    infoStep: "A média é de 24 meses após o plantio.",
                    infoCard: [
                      ["Temperatura", Icons.sunny, "20º a 32ºC"],
                      ["umidade", Icons.water_drop_rounded, "70% a 90%"],
                      ["altura", Icons.height_outlined, "1.10 a 1.50cm"],
                    ],
                    image: 'assets/muda.jpeg',
                  ),
                  ProgressItem(
                    infoStep:
                        "Se você cuidar bem é possível chegar a 15 anos com a mesma árvore",
                    infoCard: [
                      ["Temperatura", Icons.sunny, "20º a 32ºC"],
                      ["umidade", Icons.water_drop_rounded, "70% a 90%"],
                      ["altura", Icons.height_outlined, "1.10 a 1.50cm"],
                    ],
                    image: 'assets/producao.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
