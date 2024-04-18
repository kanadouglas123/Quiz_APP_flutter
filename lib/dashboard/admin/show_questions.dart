import 'package:flutter/material.dart';
import 'package:learn/model/Question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  const PlayQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}
int total=0;
int _correct=0;
int _incorrect=0;
int _notAttempted=0;


class _PlayQuizState extends State<PlayQuiz> {
  DatabaseServices databaseServices = DatabaseServices();
  QuerySnapshot<Map<String, dynamic>>? questionsSnapshot;

  @override
  void initState() {
    super.initState();
    print('${widget.quizId}');
    databaseServices.getQNA(widget.quizId).then((val) {
      setState(() {
        int total=0;
        int _correct=0;
        int _incorrect=0;
        questionsSnapshot = val;
      });
    }).catchError((error) {
      print("Error fetching QNA data: $error");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Questions",  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        actions: [
        ],
      ),
      body: questionsSnapshot == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: questionsSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return QuizPlayTile(
              questionModel: getQuestionModelFromDatasnapshot(
                  questionsSnapshot!.docs[index]),
              index: index,
            );
          },
        ),
      ),
    );
  }


}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  const QuizPlayTile({
    Key? key,
    required this.questionModel,
    required this.index,
  }) : super(key: key);

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  void _handleOptionTap(String selectedOption) {
    if (!widget.questionModel.answered) {
      setState(() {
        optionSelected = selectedOption;
        widget.questionModel.answered = true;
        if (selectedOption == widget.questionModel.correctAnswer) {
          _correct++;
        } else {
          _incorrect++;
        }
        _notAttempted--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Option Selected: $optionSelected");
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blueGrey,
            semanticContainer: true,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Q${widget.index + 1} .${widget.questionModel.question}",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 10),
          GestureDetector(
            onTap: () => _handleOptionTap(widget.questionModel.option1),
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () => _handleOptionTap(widget.questionModel.option2),
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () => _handleOptionTap(widget.questionModel.option3),
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () => _handleOptionTap(widget.questionModel.option4),
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
        ],
      ),
    );
  }
}
class DatabaseServices {
  Future<QuerySnapshot<Map<String, dynamic>>> getQNA(String quizId) async {
    try {
      return await FirebaseFirestore.instance
          .collection("Quiz")
          .doc(quizId)
          .collection("QNA")
          .get();
    } catch (e) {
      print("Error fetching QNA data: $e");
      rethrow;
    }
  }
}

QuestionModel getQuestionModelFromDatasnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> questionSnapshot) {
  List<String> options = [
    questionSnapshot.data()["option1"] ?? "",
    questionSnapshot.data()["option2"] ?? "",
    questionSnapshot.data()["option3"] ?? "",
    questionSnapshot.data()["option4"] ?? "",
  ];
  options.shuffle();

  return QuestionModel(
    question: questionSnapshot.data()["question"] ?? "",
    option1: options[0],
    option2: options[1],
    option3: options[2],
    option4: options[3],
    correctAnswer: questionSnapshot.data()["correctAnswer"] ?? "",
    answered: false,
  );
}

class OptionTile extends StatelessWidget {
  final String correctAnswer;
  final String description;
  final String option;
  final String optionSelected;

  const OptionTile({
    Key? key,
    required this.correctAnswer,
    required this.description,
    required this.option,
    required this.optionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: Text(
                "$option",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            "$description",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

