import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget{
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {

  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState(){
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: demo_data[index].image, 
                    title: demo_data[index].title, 
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    ...List.generate(demo_data.length, (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(isActive: index == _pageIndex,),
                    )),
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          _pageController.page == 2 ? 
                          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false) :
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300), 
                            curve: Curves.ease
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 12 : 6, 
      width: isActive ? 12 : 6, 
      decoration: BoxDecoration(
        color: isActive ?Colors.green : Colors.green.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}

class OnBoard{
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> demo_data = [
  OnBoard(image: "assets/icons/plant.png", title: "Bem vindo!", description: "O controle de pragas ficou mais fácil!"),
  OnBoard(image: "assets/icons/plant.png", title: "Detecção de doenças", description: "Com apenas uma imagem detecte doenças na planta"),
  OnBoard(image: "assets/icons/plant.png", title: "Dicas de tratamento", description: "Receba informações sobre a doença e dicas de tratamento"),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key, 
    required this.image, 
    required this.title, 
    required this.description,
  }) : super(key: key);
  
  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(image, height: 250,),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}