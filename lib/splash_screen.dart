import 'package:aiproject/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomePage(),
      title: Text('My AI Project', style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),),
    image: Image.network("https://post.greatist.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg"),
    backgroundColor: Colors.white,
    photoSize: 100,
    );
  }
}

