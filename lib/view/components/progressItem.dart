import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProgressItem extends StatelessWidget {
  const ProgressItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Step> getSteps() => [
          Step(
              title: Container(
                child: ImageIcon(
                  AssetImage('assets/icons/semente.png'),
                  size: 25,
                ),
              ),
              content: Container()),
          Step(
              title: Container(
                child: ImageIcon(
                  AssetImage('assets/icons/broto.png'),
                  size: 25,
                ),
              ),
              content: Container()),
          Step(
              title: Container(
                child: ImageIcon(
                  AssetImage('assets/icons/laranjeira.png'),
                  size: 25,
                ),
              ),
              content: Container()),
        ];
    return Container(
        width: size.width * 1,
        height: size.height * 0.0840,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Stepper(
          type: StepperType.horizontal,
          onStepTapped: (value) {
            print(value);
          },
          steps: getSteps(),
        ));
  }
}
