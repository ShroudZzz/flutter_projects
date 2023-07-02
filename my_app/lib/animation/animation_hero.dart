
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PhotoHero extends StatelessWidget {

  final String photo;
  final VoidCallback onTap;
  final double width;

  const PhotoHero({super.key, required this.photo, required this.onTap, required this.width});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color:  Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(photo, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {

    timeDilation = 5.0;

    const String imageURL = 'https://img.syt5.com/2021/0607/20210607042123800.jpg.420.554.jpg';
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: imageURL,
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(title: Text('Flip Page')),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: imageURL,
                    width: 100,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}
