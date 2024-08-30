
import 'package:clone/widgets/bottomnav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.push((context), MaterialPageRoute(builder: (context)=>BottomNav()));
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset('assets/netflix-removebg-preview.png'),
        ),
      ),
    );
  }
}