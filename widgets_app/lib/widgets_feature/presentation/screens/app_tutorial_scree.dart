import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  const SlideInfo({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });
}

final List<SlideInfo> slides = [
  const SlideInfo(
    title: 'Pide tu comida',
    caption:
        'Ad in adipisicing eiusmod minim consectetur exercitation culpa. Cupidatat incididunt laboris in in duis amet. Esse culpa nisi do consectetur sit labore deserunt. Ullamco pariatur esse magna voluptate occaecat sunt proident.',
    imageUrl: 'assets/images/1.png',
  ),
  const SlideInfo(
    title: 'Te llevamos tu pedido',
    caption:
        'Occaecat ea fugiat fugiat ipsum velit. Do et do consequat nisi culpa sunt excepteur amet. Nulla qui aliqua ullamco duis irure et Lorem nisi ad eu. Magna eiusmod qui ut magna ad irure veniam esse tempor adipisicing. Qui elit officia eu elit irure minim incididunt irure commodo. Lorem ipsum tempor eu exercitation laborum est irure.',
    imageUrl: 'assets/images/2.png',
  ),
  const SlideInfo(
    title: 'Buen provecho',
    caption:
        'Anim aute id fugiat laboris reprehenderit eiusmod voluptate est et duis aute occaecat. Qui duis pariatur consectetur id qui tempor mollit non. Voluptate sunt velit amet aliquip laborum elit sit cillum aliquip commodo sint. Ipsum labore voluptate nulla et veniam dolor et. Mollit veniam esse et labore voluptate aliqua Lorem laborum.',
    imageUrl: 'assets/images/3.png',
  ),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = 'app_tutorial_screen';
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  late PageController _pageController;
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _pageController.addListener(() {
      if (!endReached && _pageController.page! > slides.length - 1.5) {
        setState(() {
          endReached = true;
        });
      } else if (endReached && _pageController.page! < slides.length - 1.5) {
        setState(() {
          endReached = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: slides
                .map((slide) => SlideView(
                    title: slide.title,
                    caption: slide.caption,
                    imageUrl: slide.imageUrl))
                .toList(),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Skip'),
              ),
            ),
          ),
          endReached
              ? FadeInRight(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FilledButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('Start'),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class SlideView extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const SlideView({
    super.key,
    required this.title,
    required this.caption,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl),
            const SizedBox(height: 20),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            Text(caption, style: captionStyle),
          ],
        ),
      ),
    );
  }
}
