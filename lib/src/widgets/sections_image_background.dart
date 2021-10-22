import 'package:flutter/material.dart';

class SectionImageBackground extends StatelessWidget {
  const SectionImageBackground({
    Key? key,
    required this.y,
    required this.x,
    required this.fadeInAnimationController,
    required this.fadeInImage,
    required this.imageRoute
  }) : super(key: key);

  final double y;
  final double x;
  final AnimationController fadeInAnimationController;
  final Animation<double> fadeInImage;
  final String imageRoute; 

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: 0,
      bottom: y * -5.0,
      right: x * -5.0,
      left: x * 5.0,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: fadeInAnimationController,
            builder: (BuildContext context, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.9],
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(fadeInImage.value),
                      Colors.transparent
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  imageRoute,
                  fit: BoxFit.cover,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  colorBlendMode: BlendMode.color,
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.infinity,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}