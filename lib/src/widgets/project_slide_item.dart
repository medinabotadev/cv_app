import 'package:flutter/material.dart';
import '../models/project.dart';

class CarouselSliderItem extends StatelessWidget {
  const CarouselSliderItem({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.black,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.4,
                  1.0
                ],
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
                  Colors.transparent,
                ],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              child: Image.asset(
                project.photoUrl,
                fit: BoxFit.cover,
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(1), // TODO: Original color when in center
                colorBlendMode: BlendMode.color,
                width: double.infinity,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            //top: 0,//-40 + (y * 6),
            bottom: 45,//(y * -6),
            //right: 0,//(x * -9),
            left: 15,//35 + (x * 9),(
            child: Text(project.name, style: Theme.of(context).textTheme.headline4!.merge(const TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0, color: Color(0xFFFFFFFF))),)
          ),
          AnimatedPositioned(
            //top: 0,//-40 + (y * 6),
            bottom: 20,//(y * -6),
            //right: 0,//(x * -9),
            left: 15,//35 + (x * 9),(
            duration: const Duration(milliseconds: 500),
            child: Text(project.availability(), style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: 12, color: Theme.of(context).hintColor)),),
          )
        ],
      )
    );
  }
}