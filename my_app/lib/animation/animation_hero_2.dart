import 'package:flutter/material.dart';
import 'dart:math' as math;

class Photo extends StatelessWidget {
  final String photo;
  final Color? color;
  final VoidCallback onTap;

  const Photo({super.key, required this.photo, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints size) {
          return Image.network(photo, fit: BoxFit.cover);
        }),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final double clipRectSize;
  final Widget child;

  const RadialExpansion({super.key, required this.maxRadius, required this.child}) : clipRectSize = 2.0 * (maxRadius / math.sqrt2);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
            child: ClipRect(
              child: child,
            ),
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxradius = 128.0;
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  const RadialExpansionDemo({super.key});

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxradius * 2.0,
                height: kMaxradius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxradius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(description, style: const TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 3.0),
              const SizedBox(height: 16.0)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, String imageName, String description) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxradius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
                  return AnimatedBuilder(animation: animation, builder: (BuildContext context, Widget? child) {
                    return Opacity(opacity:
                    opacityCurve.transform(animation.value),
                      child: _buildPage(context, imageName, description),
                    );
                  });
                })
              );
            },
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero 2')),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'https://img.syt5.com/2021/0315/20210315055931894.jpg.420.554.jpg', 'ZBZ'),
            _buildHero(context, 'https://img.syt5.com/2020/1012/20201012024436823.jpg.420.554.jpg', 'WYS'),
            _buildHero(context, 'https://img.syt5.com/2020/0820/20200820090817773.jpg.420.554.jpg', '36D'),
          ],
        ),
      ),
    );
  }
}