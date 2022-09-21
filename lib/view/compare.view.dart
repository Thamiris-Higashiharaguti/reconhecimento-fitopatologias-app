import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ComparePage extends StatefulWidget {
  var photoLink;
  List<String> arquivos;
  ComparePage({required this.photoLink, required this.arquivos, super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: SizedBox(
                  width: size.width,
                  height: size.height * 0.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Column(
                        children: [
                          Image.file(
                            widget.photoLink,
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.5,
                          ),
                        ],
                      )))),
          Positioned(
            top: size.height * 0.5,
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.5,
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
                                  height: size.height * 0.5,
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
    );
  }
}
