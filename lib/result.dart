import 'package:flutter/material.dart';
import 'package:learn/dashboard/student/subject.dart';
import 'dart:async';

class Results extends StatefulWidget {
  final int total, correct, incorrect,notAttempted;

  Results({
    required this.incorrect,
    required this.total,
    required this.correct, required this.notAttempted,
  });

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late int correct;

  @override
  void initState() {
    super.initState();
    correct = widget.correct;
  }

  void resetResults() {
    setState(() {
      correct =0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool passed = correct >= 5; // Check if the user passed or failed
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          passed
              ? Container(
            padding: EdgeInsets.all(16),
            color: Colors.green,
            child: Text(
              "Congratulations!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
              : Container(
            padding: EdgeInsets.all(16),
            color: Colors.red,
            child: Text(
              "Your below 5. Failed!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50,),
                      AnimatedTextMotion(),
                      SizedBox(height: 30,),
                      Material(
                        color: Colors.blue,
                        shadowColor: Colors.yellowAccent,
                        elevation: 10,
                        borderRadius: BorderRadius.circular(40),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.yellowAccent,
                            radius: 65,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 40,
                              child: Text(
                                "${widget.correct} /10",
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.yellowAccent,
                        color: Colors.blue,
                        child: Text(
                          "You answered ${widget.incorrect} questions incorrectly and ${10-(widget.incorrect + widget.correct)}  notAttempted",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 74),
                      GestureDetector(
                        onTap: () {
                          int correct=0;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Subject(),));
                          setState(() {});
                          // Navigate back to home
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.yellow[400],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Go to home",
                            style: TextStyle(color: Colors.black, fontSize: 19,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class AnimatedTextMotion extends StatefulWidget {
  @override
  _AnimatedTextMotionState createState() => _AnimatedTextMotionState();
}

class _AnimatedTextMotionState extends State<AnimatedTextMotion> {
  double _positionX = 0.0; // Initial X position of the text
  bool _moveRight = true; // Flag to indicate the direction of motion

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }
  // Function to start the animation
  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 20), (Timer timer) {
      setState(() {
        // Update the X position to move the text
        if (_moveRight) {
          _positionX += 1.0;
          if (_positionX >= 300.0) {
            _moveRight = false;
          }
        } else {
          _positionX -= 1.0;
          if (_positionX <= 0.0) {
            _moveRight = true;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: AnimatedContainer(
          duration: Duration(milliseconds: 50), // Duration of the animation
          curve: Curves.linear, // Linear animation curve for continuous motion
          transform: Matrix4.translationValues(_positionX, 0.0, 0.0), // Translate the text horizontally
          child: Material(
              borderRadius: BorderRadius.circular(30),
            color: Colors.blue,
            elevation: 10,
              shadowColor: Colors.yellowAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Congratulations Your score is", style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold,fontSize: 25),),
              ))
      ),
    );
  }
}
