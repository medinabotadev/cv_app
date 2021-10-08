import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/user.dart';

class HomeScreenHeaderElements extends StatefulWidget {
  final User user;
  const HomeScreenHeaderElements({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreenHeaderElements> createState() => _HomeScreenHeaderElementsState();
}

class _HomeScreenHeaderElementsState extends State<HomeScreenHeaderElements> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: false,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _HeaderWaver(waveColor: Theme.of(context).scaffoldBackgroundColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 70.0),
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 2)),
                      ],
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 5.0
                    ),
                    shape: BoxShape.circle
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(widget.user.getInitials(), style: Theme.of(context).textTheme.headline4,),
                    foregroundImage: NetworkImage(widget.user.photoUrl!)
                  ),
                ),
                Text(widget.user.occupation!, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0), child: Text(widget.user.bio!, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1)),
                const Flexible(child: SizedBox())
            ]
          ),
        ],
      ),
    );
  }
}

class _HeaderWaver extends CustomPainter{
  final Color waveColor;
  _HeaderWaver({
    required this.waveColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final brush             = Paint();
          brush.strokeWidth = 5.0;
          brush.color       = waveColor;
          brush.style       = PaintingStyle.fill;

    final path              = Path();
          path.moveTo(0, size.height * 0.50);
          path.quadraticBezierTo(size.width * 0.25, size.height * 0.50, size.width * 0.50, size.height * 0.30);
          path.quadraticBezierTo(size.width * 0.75, size.height * 0.10, size.width, size.height * 0.10);
          path.lineTo(size.width, 0);
          path.lineTo(0, 0);

    canvas.drawShadow(path.shift(const Offset(0, 4)), waveColor.withOpacity(0.5), 4.0, true);
    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}