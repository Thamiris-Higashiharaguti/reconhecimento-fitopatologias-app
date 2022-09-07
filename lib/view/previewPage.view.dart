import 'dart:io';
import 'package:fitopatologia_app/view/home.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PreviewPage extends StatefulWidget {
  File? teste;
  PreviewPage({Key? key, this.teste}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with SingleTickerProviderStateMixin {
  bool uploading = false;
  late AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000))
    ..repeat(reverse: true);

  late Animation<Offset> _animationVertical =
      Tween(begin: Offset(0, -50), end: Offset(0, 50)).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                  child: Image.file(
                widget.teste!,
                fit: BoxFit.cover,
              )),
              if (uploading != true) ...[
                Container()
              ] else ...[
                Center(
                  child: SlideTransition(
                    position: _animationVertical,
                    child: Icon(
                      Icons.upload,
                      size: 40,
                    ),
                  ),
                )
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: IconButton(
                          icon: Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 102, 255, 0),
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              uploading = true;
                            });

                            /*
                            Navigator.push(
                              context, // error
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomePage(teste: teste);
                                },
                              ),
                            );*/
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
