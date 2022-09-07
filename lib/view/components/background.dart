import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
                opacity: 0.1,
                child: Image.asset("assets/top.png", width: size.width)),
          ),
          Positioned(
            bottom: -10,
            right: 0,
            child: Opacity(
                opacity: 0.1,
                child: Image.asset("assets/bottom.png", width: size.width)),
          ),
          child
        ],
      ),
    );
  }
}
