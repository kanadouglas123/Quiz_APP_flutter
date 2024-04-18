import 'package:flutter/material.dart';
import 'package:learn/dashboard/student/Home.dart';
import 'package:learn/dashboard/student/subject.dart';
import 'package:learn/views/login.dart';
import 'package:learn/views/register.dart';
class QuizDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminCard(),
              SizedBox(height: 16.0),
              StudentCard(),
              SizedBox(height:150,),
              Text("By group two",style: TextStyle(color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      elevation: 5,
      borderRadius: BorderRadius.circular(20),

      child: Card(
        color: Colors.yellow,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 20.0,color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Manage quizzes, questions, and users.',
                style: TextStyle(fontSize: 16.0,color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text('Admin Actions', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Colors.yellow,
        shadowColor: Colors.pinkAccent,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Dashboard',
                style: TextStyle(color: Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Take quizzes and view results.',
                style: TextStyle(fontSize: 16.0,color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Subject()));
                      // Add student actions here
                    },
                    child: Text('Start Quiz' ,style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }
}
