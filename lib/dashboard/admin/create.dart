import 'package:flutter/material.dart';
import 'package:learn/dashboard/admin/database.dart';
import 'package:random_string/random_string.dart';
import 'package:learn/dashboard/admin/set_question.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizNumber, quizTitle, quizDescription;
  DatabaseService databaseServices = DatabaseService();
  String quizId = randomAlphaNumeric(16);
  bool isLoading = false;

  void createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        Map<String, dynamic> quizData = {
          "quizId": quizId,
          "quizNumber": quizNumber,
          "quizTitle": quizTitle,
          "quizDescription": quizDescription,
        };

        await databaseServices.addQuizData(quizData, quizId);

        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Set(quizId: quizId),
          ),
        );

      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("Error creating quiz: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create quiz'),
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
              "Create",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Quiz",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? "Enter quiz number" : null,
                  decoration: InputDecoration(hintText: "Quiz Number"),
                  onChanged: (value) {
                    quizNumber = value;
                  },
                ),
                SizedBox(height: 6),
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? "Enter Quiz title" : null,
                  decoration: InputDecoration(hintText: "Quiz title"),
                  onChanged: (value) {
                    quizTitle = value;
                  },
                ),
                SizedBox(height: 6),
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? "Enter Quiz description" : null,
                  decoration:
                  InputDecoration(hintText: "Quiz description"),
                  onChanged: (value) {
                    quizDescription = value;
                  },
                ),
                SizedBox(height: 6),
                Spacer(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      createQuizOnline();
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                      color:Colors.black,
                    )
                        : Text(
                      "Create",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
