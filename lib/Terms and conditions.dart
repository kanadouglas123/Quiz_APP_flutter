import 'package:flutter/material.dart';
import 'package:learn/dashboard/student/subject.dart';

class QuizTermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Quiz Terms and Conditions', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. The quiz consists of 10 questions.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '2. Each quiz has a time limit of 40 seconds.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '3. Once the timer for a question expires, you cannot answer it.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '4. You must answer all questions within the given time limit.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '5. The quiz will automatically go back to home screen when the time is up.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '6. You cannot select two options in one question.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '7. Make sure you have a stable internet connection before starting the quiz.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '8. Any attempt to cheat or manipulate the quiz will result in disqualification.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '9. Your score will be displayed at the end of the quiz.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '10. By starting the quiz, you agree to abide by these terms and conditions.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Subject(),));
                  },
                  child: Material(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.yellowAccent,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 55,right: 55,top: 8, bottom: 8),
                          child: Text('Accept' ,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

