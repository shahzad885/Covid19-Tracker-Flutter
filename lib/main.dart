

import 'package:covid_19_tracker/view/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Covid19tracker());
}

class Covid19tracker extends StatelessWidget {
  const Covid19tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
     
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}