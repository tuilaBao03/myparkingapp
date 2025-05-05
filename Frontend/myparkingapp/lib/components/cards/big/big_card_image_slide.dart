// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../constants.dart';

import '../../dot_indicators.dart';
import 'big_card_image.dart';

class BigCardImageSlide extends StatefulWidget {
  final bool isBanner;
  const BigCardImageSlide({
    super.key,
    required this.images, required this.active,
    required this.isBanner,
  });

  final List images;
  final String active;

  @override
  State<BigCardImageSlide> createState() => _BigCardImageSlideState();
}

class _BigCardImageSlideState extends State<BigCardImageSlide> {
  int intialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(1),
      child: AspectRatio(
        aspectRatio: 1.81,
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  intialIndex = value;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) =>
                  BigCardImage(image: widget.images[index], isBanner: widget.isBanner,),
            ),
            Positioned(
              bottom: defaultPadding,
              right: defaultPadding,
              child: Row(
                children: List.generate(
                  widget.images.length,
                  (index) => DotIndicator(
                    isActive: intialIndex == index,
                    activeColor: Colors.white,
                    inActiveColor: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Text(widget.active.toUpperCase(),style: TextStyle(
                color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold
              ),),
            )

          ],
        ),
      ),
    );
  }
}
