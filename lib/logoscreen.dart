import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
//import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

class LogoScreenPage extends StatefulWidget {
  const LogoScreenPage({super.key});

  @override
  State<LogoScreenPage> createState() => _LogoScreenPage();
}

class _LogoScreenPage extends State<LogoScreenPage> {
  @override
  void initState() {
    super.initState();

    // Navigate to home after 3 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/companymotto');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFB586BE),
              Color(0xFF131313)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
            )
          ),
          child:SafeArea(
            child: Container(
              //width: 260,
              //height: 60,
              //margin: EdgeInsets.only(top: 120),
              alignment: Alignment.center,
              child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 4.0,
                  top: 4.0,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  //child: ImageFiltered(
                    //imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child:  Image.asset('assets/companylogo.png',
                  width: 329,
                  height: 73,
                  fit: BoxFit.cover,
                  color: Color(0x40000000),),
                  
                  )
                ),
                  //Actual image
                  Image.asset(
                    'assets/companylogo.png',
                    width: 329,
                    height: 73,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
           ),
          ),
          /*child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  color: Color(0x40000000)
                )
              ]
            ),
            child: Image.asset('assets/companylogo.png',
          width: 329,
          height: 73,
          //color: Colors.transparent,
          ),
          ),*/
      ),
      
    );
  } 
}