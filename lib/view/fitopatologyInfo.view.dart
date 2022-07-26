import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/model/diagnostico.model.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FitopatologyInfo extends StatefulWidget {
  List<String> arquivos;
  final DiagnosticoModel modelDiag;
  FitopatologyInfo(
      {super.key, required this.arquivos, required this.modelDiag});

  @override
  State<FitopatologyInfo> createState() => _FitopatologyInfoState();
}

class _FitopatologyInfoState extends State<FitopatologyInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _controller = PageController();
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.modelDiag.descricao! == "") ...[
                Container(),
              ] else ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Descição: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                          color: Colors.red,
                        )
                      ],
                    ),
                    Text(widget.modelDiag.descricao!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tratamento:",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(widget.modelDiag.tratamento!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ],
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 1,
                height: size.height * 0.3,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.arquivos.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: size.width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                    width: size.width,
                                    height: size.height * 0.3,
                                    fit: BoxFit.fill,
                                    imageUrl: widget.arquivos[index]),
                              ],
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: widget.arquivos.length,
                    effect: SwapEffect(
                      activeDotColor: Color.fromARGB(255, 0, 71, 2),
                      dotColor: Color.fromARGB(255, 126, 126, 126),
                      dotHeight: 30,
                      dotWidth: 30,
                      spacing: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
