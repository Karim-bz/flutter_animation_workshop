import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  AnimationController? _controller;
  Animation? _colorAnimation; // control the color Animation
  Animation<double>? _sizeAnimation; // control the size Animation
  Animation? _curve;

  @override
  void initState() {
    super.initState();

    // initialise Animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // initialise curve Animation
    _curve = CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);

    // initialise color Tween to change Icon Color
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller!);

    // use Tween Sequence to control the size of the Icon and animate it
    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30),
          weight: 50,
        ),
      ],
    ).animate(_controller!);

    // add Listener to the Animation Controller to check values
    _controller!.addListener(() {
      // print(_controller!.value);
      // print(_colorAnimation!.value);
    });

    // add Listener to check the Animation controller Status and upadte a bool variable
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  // dispose the Animation controller when the widget leaves the screen
  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //add the animation to the Icon Btn Widget using Animation Builder
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation!.value,
            size: _sizeAnimation!.value,
          ),
          onPressed: () {
            // check if icon is clicked or not to make the action
            isFav ? _controller!.reverse() : _controller!.forward();
          },
        );
      },
    );
  }
}
