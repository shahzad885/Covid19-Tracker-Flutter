import 'dart:async';

import 'package:covid_19_tracker/view/World_States.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
    ()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  const WorldStatesScreen() )),
    
    
    );
  }
 
@override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.grey.shade300,
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AnimatedBuilder(
        animation: _controller,
        child: const SizedBox(
          height: 200,
          width: 200,
          child: Image(image: AssetImage('images/virus.png')),
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * math.pi,
            child: child,
          );
        },
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height*.08,
      ),
      const Align(
        alignment: Alignment.center,
        child: Text('Covid-19 \n Tracker App', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center,))
    ],
  ),
);
  }
}
