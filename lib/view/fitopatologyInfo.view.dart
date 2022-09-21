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
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: Text(
              widget.modelDiag.doenca!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.height * 0.05,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width * 1,
              height: size.height * 0.85,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.modelDiag.descricao!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 1,
                      height: size.height * 0.4,
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
                                          height: size.height * 0.4,
                                          imageUrl: widget.arquivos[index]),
                                    ],
                                  )));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
