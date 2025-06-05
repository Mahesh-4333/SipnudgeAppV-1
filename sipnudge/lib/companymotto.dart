import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class CompanyMottoPage extends StatefulWidget {
  const CompanyMottoPage({super.key});

  @override
  State<CompanyMottoPage> createState() => _CompanyMottoPage();
}

class _CompanyMottoPage extends State<CompanyMottoPage> {

  @override
  void initState() {
    super.initState();

    // Navigate to home after 3 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/signin_signupsage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity, // Ensure it fills the full screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB586BE), Color(0xFF131313)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            //face icon
            /*Positioned(
            
            top: MediaQuery.of(context).size.height * 0.1, // Adjust top margin
            left: MediaQuery.of(context).size.width * 0.4, // Adjust left margin
            
            child: Icon(
              Icons.face_outlined, // Or a custom icon if available
              size: 60.0,
              color: Colors.white70,
            ),
          ),*/
          SafeArea(
            child: Container(
              //width: double.infinity,
              //height: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                
                children: [
                  Positioned.fill(
                    left: 10.0,
                    //right: 2.0,
                    top: 10.0,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                       child: Image.asset('assets/back new app sipnudge.png',
                       width: 975,
                       height: 975,
                       fit: BoxFit.cover,
                       color: Colors.black.withOpacity(0.25)),
                       )
                    ),
                    Image.asset('assets/back new app sipnudge.png',
                    width: 975,
                    height: 975,
                    fit: BoxFit.cover,)
                            ],
                          ),
                        )),
                        // Fullscreen background image
                      /*Positioned.fill(
                          left: 10.0,
                          top: 10.0,
                          child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Image.asset(
                            'assets/back new app sipnudge.png',
                            width: 275,
                            height: 275,
                            fit: BoxFit.cover,
                            //color: Colors.black // Makes image fill screen
                          ),
                        
                        ),
                      ),*/
                        //Actual image
                      
                        // Positioned gradient text
                        Positioned(
                              bottom: 100, // Adjust as needed
                              left: 0,
                              right: 0,
                              child: Center(
                              child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                              style: const TextStyle(
                              fontSize: 33,
                              fontFamily: 'MuseoModerno-Bold',
                            ),
                        children: [
                          const TextSpan(
                              text: 'AI ',
                              style: TextStyle(
                                fontSize: 33,
                                fontFamily: 'MuseoModerno-Bold',
                                color: Color(0xFFE6A1F3)),
                            ),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFCBA7E0),Color(0xFF89B4DD), Color(0xFFA6F7FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                          blendMode: BlendMode.srcIn,
                          child: const Text(
                            'Meets',
                            style: TextStyle(
                              fontSize: 33,
                              fontFamily: 'MuseoModerno-Bold',
                              color: Colors.white, // Required, will be masked by ShaderMask
                            ),
                          ),
                        ),
                      ),
                      /*const TextSpan(
                            text: 'Hydration',
                            style: TextStyle(
                            fontSize: 33,
                            fontFamily: 'MuseoModerno-Bold',
                            color: Color(0xFF89EFF5)),
                        ),*/
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                            fontSize: 33,
                            fontFamily: 'MuseoModerno-Bold',
                            ),
                            children: [
                              const TextSpan(
                                  text: 'Hydration',
                                  style: TextStyle(
                                  fontSize: 33,
                                  fontFamily: 'MuseoModerno-Bold',
                                  color: Color(0xFF89EFF5)),
                                ),
                            ]
                    ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
