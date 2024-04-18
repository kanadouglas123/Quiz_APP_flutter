import 'package:flutter/material.dart';
import 'package:learn/dashboard/admin/Home.dart';
import 'package:learn/dashboard/admin/database.dart';

class Set extends StatefulWidget {
  final String quizId;

  Set({required this.quizId});

  @override
  State<Set> createState() => _SetState();
}

class _SetState extends State<Set> {
  String? question, option1, option2, option3, option4;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  DatabaseService databaseServices = DatabaseService();

  void uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start
      });

      Map<String, String> questionData = {
        "question": question!,
        "option1": option1!,
        "option2": option2!,
        "option3": option3!,
        "option4": option4!,
      };

      try {
        await databaseServices.addQuestionData(questionData, widget.quizId);
        setState(() {
          _isLoading = false; // Stop loading
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Question added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false; // Stop loading
        });
        print('Error uploading question data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add question'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Set",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "questions",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? "Enter question" : null,
                        decoration: InputDecoration(hintText: "Question"),
                        onChanged: (value) {
                          setState(() {
                            question = value;
                          });
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? "Enter option1" : null,
                        decoration:
                        InputDecoration(hintText: "Option 1(correct)"),
                        onChanged: (value) {
                          setState(() {
                            option1 = value;
                          });
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? "Enter option2" : null,
                        decoration: InputDecoration(hintText: "Option 2"),
                        onChanged: (value) {
                          setState(() {
                            option2 = value;
                          });
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? "Enter option3" : null,
                        decoration: InputDecoration(hintText: "Option 3"),
                        onChanged: (value) {
                          setState(() {
                            option3 = value;
                          });
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? "Enter option4" : null,
                        decoration: InputDecoration(hintText: "Option 4"),
                        onChanged: (value) {
                          setState(() {
                            option4 = value;
                          });
                        },
                      ),

                      SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
                              },
                              child: Text('Submit'),
                            ),
                            SizedBox(width: 80),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  uploadQuestionData();
                                }
                              },
                              child: Text('Set Question'),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
