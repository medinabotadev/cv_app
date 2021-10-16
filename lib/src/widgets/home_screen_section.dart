import 'package:flutter/material.dart';
import '../models/section.dart';

class HomeScreenSection extends StatefulWidget {
  final List<Section> sections;
  const HomeScreenSection({ 
    Key? key,
    required this.sections
  }) : super(key: key);

  @override
  _HomeScreenSectionState createState() => _HomeScreenSectionState();
}

class _HomeScreenSectionState extends State<HomeScreenSection> with TickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double>   moveSectionUpFirst;
  late Animation<double>   moveSectionUpSecond;
  late Animation<double>   moveSectionUpThird;
  late Animation<double>   moveSectionUpFourth;
  late Animation<double>   moveSectionUpFifth;
  late List<Animation>     moveSectionUpList;
  late Animation<double>   fadeSectionInFirst;
  late Animation<double>   fadeSectionInSecond;
  late Animation<double>   fadeSectionInThird;
  late Animation<double>   fadeSectionInFourth;
  late Animation<double>   fadeSectionInFifth;
  late List<Animation>     fadeSectionInList;

  late AnimationController onTapAnimationController;
  late Animation<double>   onTapFadeOut;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    moveSectionUpFirst = Tween(begin: 150.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.20, curve: Curves.easeInOutQuart))
    );
    moveSectionUpSecond = Tween(begin: 150.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.21, 0.40, curve: Curves.easeInOutQuart))
    );
    moveSectionUpThird = Tween(begin: 150.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.41, 0.60, curve: Curves.easeInOutQuart))
    );
    moveSectionUpFourth = Tween(begin: 150.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.61, 0.8, curve: Curves.easeInOutQuart))
    );
    moveSectionUpFifth = Tween(begin: 150.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.81, 1.0, curve: Curves.easeInOutQuart))
    );
    fadeSectionInFirst = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.20, curve: Curves.easeInOutQuart))
    );
    fadeSectionInSecond = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.21, 0.40, curve: Curves.easeInOutQuart))
    );
    fadeSectionInThird = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.41, 0.60, curve: Curves.easeInOutQuart))
    );
    fadeSectionInFourth = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.61, 0.80, curve: Curves.easeInOutQuart))
    );
    fadeSectionInFifth = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.81, 1.0, curve: Curves.easeInOutQuart))
    );
    moveSectionUpList = [
      moveSectionUpFirst,
      moveSectionUpSecond,
      moveSectionUpThird,
      moveSectionUpFourth,
      moveSectionUpFifth,
    ];
    fadeSectionInList = [
      fadeSectionInFirst,
      fadeSectionInSecond,
      fadeSectionInThird,
      fadeSectionInFourth,
      fadeSectionInFifth,
    ];

    onTapAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    onTapFadeOut   = Tween(begin: 1.0, end: 0.0).animate(onTapAnimationController);
    super.initState();
    
  }

  @override
  void dispose() {
    animationController.dispose();
    onTapAnimationController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  _onSelected(int index){
    setState(() => _selectedIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return  Positioned(
      top: 420.0,
      left: 20.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _generateChildrens(widget.sections, _selectedIndex, context, animationController, moveSectionUpList, fadeSectionInList)
      )
    );
  }




    List<Widget> _generateChildrens(List<Section> sections, int _selectedIndex, BuildContext context, AnimationController animationController, List<Animation> moveSectionUpList, List<Animation> fadeSectionInList) {
      var list = sections.map<List<Widget>>((section) {
          var index      = sections.indexOf(section);
          var widgetList = <Widget>[];
          widgetList.add(
            GestureDetector(
              onTap: (){
                _onSelected(index);
                onTapAnimationController.forward();
                void onTap(){
                  if(onTapAnimationController.status == AnimationStatus.completed){
                      Navigator.of(context).pushNamed('/SectionScreen', arguments: section);
                      onTapAnimationController.reset();
                      animationController.reset();
                      onTapAnimationController.removeListener(onTap);
                    }
                  }
                onTapAnimationController.addListener(onTap);
              },
              child: AnimatedBuilder(
                animation: onTapAnimationController,
                builder: (BuildContext context, child) {
                  return Opacity(
                    opacity: _selectedIndex == index ? 1.0 : onTapFadeOut.value,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (BuildContext context, child){
                        return Transform.translate(
                          offset: Offset(0, moveSectionUpList[index % 5].value),
                          child: Opacity(opacity: fadeSectionInList[index % 5].value, child: Hero(
                            tag: section.argument,
                            child: Text(section.name, style: Theme.of(context).textTheme.headline4,)
                            )
                          )
                        );
                      },
                    ),
                  );
                }
              ),
            )
          );
          // widgetList.add(
          //   AnimatedBuilder(
          //     animation: onTapAnimationController,
          //     builder: (BuildContext context, child) {
          //       return Opacity(
          //         opacity: _selectedIndex == index ? 1.0 : onTapFadeOut.value,
          //         child: AnimatedBuilder(
          //           animation: animationController,
          //           builder: (BuildContext context, child){
          //             return Transform.translate(
          //               offset: Offset(0, moveSectionUpList[index % 5].value),
          //               child: Opacity(opacity: fadeSectionInList[index % 5].value, child: Container(width: 200.0, height: 2.0, color: Theme.of(context).hintColor))
          //             );
          //           },
          //         ),
          //       );
          //     }
          //   )
          // );
          widgetList.add(const SizedBox(height: 35.0,));
          return widgetList;
        },
      ).toList();
    var flat = list.expand((i) => i).toList();
    return flat;
  }
}
