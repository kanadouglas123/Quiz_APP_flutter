import 'package:flutter/material.dart';
import 'package:learn/Eng/Home.dart';
import 'package:learn/SST/Home.dart';
import 'package:learn/Sci/Home.dart';
import 'package:learn/Terms%20and%20conditions.dart';
import 'package:learn/dashboard/admin/Home.dart';
import 'package:learn/math/Home.dart';
import 'dart:async';

class Subject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text("subjects",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    AnimatedTextMotion(),

                    SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection:  Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SST(),
                          SizedBox(width: 10,),
                          SCIENCE(),
                          SizedBox(width: 10,),
                          Math(),
                          SizedBox(width: 10,),
                          English(),
                        ],
                      ),
                    ),
                    SizedBox(height: 80,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizTermsAndConditions(),));
                      },
                      child: Material(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.yellow[400],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 55,right: 55,top: 8, bottom: 8),
                            child: Text("Terms and conditions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          )),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      elevation: 5,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        height: 290,
        width: 220,

        decoration: BoxDecoration(  color: Colors.yellow,borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/sst.jpg', // Image path
                  height: 150, // Adjust height as needed
                  width: 200, // Adjust width as needed
                  fit: BoxFit.cover, // Adjust the image size to cover the entire container
                ),
              ),
              SizedBox(height: 10), // Add spacing between image and text
              Center(
                child: Text(
                  'Social Studies',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => SSTi(),));
                  },
                  child: Material(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 55,right: 55,top: 8, bottom: 8),
                        child: Text("It's Start",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SCIENCE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 290,
        width: 220,
        decoration: BoxDecoration(  color: Colors.yellow,borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/sci.jpeg', // Image path
                  height: 150, // Adjust height as needed
                  width: 200, // Adjust width as needed
                  fit: BoxFit.cover, // Adjust the image size to cover the entire container
                ),
              ),
              SizedBox(height: 10), //
              Center(
                child: Text(
                  'SCIENCE',
                  style: TextStyle(color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Scii(),));
                  },
                  child: Material(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 55,right: 55,top: 8, bottom: 8),
                        child: Text("It's Start",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      )),
                ),
              )

            ],

          ),
        ),
      ),
    );
  }
}
class English extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      elevation: 5,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        height: 290,
        width: 220,
        decoration: BoxDecoration(  color: Colors.yellow,borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/English.jpg', // Image path
                  height: 150, // Adjust height as needed
                  width: 200, // Adjust width as needed
                  fit: BoxFit.cover, // Adjust the image size to cover the entire container
                ),
              ),
              SizedBox(height: 10), //
              Center(
                child: Text(
                  'English',
                  style: TextStyle(
                    fontSize: 20.0,color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Engi(),));
                  },
                  child: Material(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 55,right: 55,top: 8, bottom: 8),
                        child: Text("It's Start",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      )),
                ),
              )


            ],

          ),
        ),
      ),
    );
  }
}

class Math extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.green,
      color: Colors.yellow,
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height:290,
        width: 220,
        decoration: BoxDecoration(  color: Colors.yellow,borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/math.jpg', // Image path
                  height: 150, // Adjust height as needed
                  width: 200, // Adjust width as needed
                  fit: BoxFit.cover, // Adjust the image size to cover the entire container
                ),
              ),
              SizedBox(height: 10), //
              Center(
                child: Text(
                  'Math',
                  style: TextStyle(color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          SizedBox(height: 20,),
          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Mathi(),));
              },
              child: Material(
                borderRadius: BorderRadius.circular(17),
                color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 55,right: 55,top: 8, bottom: 8),
                    child: Text("It's Start",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  )),
            ),
          ),


            ],

          ),
        ),
      ),
    );
  }
}

///moving the word

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
    padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text("Welcome to the Quiz society", style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold,fontSize: 25),))
        ),
    ));
  }
}
