import 'package:flutter/material.dart';
import 'package:learn/dashboard/student/Quiz_play.dart';
// import 'package:learn/dashboard/student/Home.dart';
// import 'package:learn/dashboard/student/Quiz_play.dart';
import 'package:learn/dashboard/student/subject.dart';
import 'package:learn/model/Question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:learn/result.dart';

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

Stream? infoStream=null;



class _PlayQuizState extends State<PlayQuiz> {
  DatabaseServices databaseServices = DatabaseServices();
  late Timer timer;
  int totalTimeInSeconds = 40;
   QuerySnapshot<Map<String, dynamic>>? questionsSnapshot;

  void initState() {
  startTimer();
    super.initState();
    print('${widget.quizId}');
    databaseServices.getQNA(widget.quizId).then((val) {
      _correct = 0;
      _incorrect=0;
      _notAttempted=0;
      questionsSnapshot = val;
      setState(() {});
    }).catchError((error) {
      print("Error fetching QNA data: $error");
    });
  if(infoStream == null){
    infoStream = Stream<List<int>>.periodic(
        Duration(milliseconds: 100), (x){
      print("this is x $x");
      return [_correct, _incorrect] ;
    });
  }

  super.initState();
  }
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        if (totalTimeInSeconds < 1) {
          t.cancel();
          // Time's up logic
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Subject(),));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Time Out!'),
            ),
          );
        } else {
          totalTimeInSeconds--;
        }
      });}
  @override
  void dispose() {
    timer.cancel();

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Subject(),));
          },
            child: BackButtonIcon()),
        iconTheme: const IconThemeData(
          color: Colors.blue,
        ),
        title: const Text("Answer all questions",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        elevation: 4,
        shadowColor: Colors.orange,
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Colors.black54,
            child: Text(
              '${(totalTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(totalTimeInSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
      body: questionsSnapshot == null
          ? const Center(
        child: CircularProgressIndicator(),)
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InfoHeader(
                    length: questionsSnapshot!.docs.length,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
                          itemCount: questionsSnapshot!.docs.length,
                          itemBuilder: (context, index) {
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(
                        questionsSnapshot!.docs[index]),
                    index: index,
                  );
                          },
                        ),
                ],
              ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child:const  Icon(Icons.check,color: Colors.white,size: 35,),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Results(incorrect: _incorrect, total: total, correct: _correct,notAttempted: _notAttempted,)));
          setState(() {
          });},),);
  }


  }


class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 14),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          NoOfQuestionTile(
            text: "Total",
            number: widget.length,
          ),
          NoOfQuestionTile(
            text: "Correct",
            number: _correct,
          ),
          NoOfQuestionTile(
            text: "Incorrect",
            number: _incorrect
          ),
          NoOfQuestionTile(
              text: "Not Attempted",
              number: 10-_incorrect - _correct
          ),


        ],
      ),
    ) ;Container();
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
          TextButton(
            onPressed: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctAnswer) {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                    setState(() {});

                } else {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                }
              }
            },
            child: SingleChildScrollView(scrollDirection:Axis.horizontal ,
              child: OptionTile(
                option: "A",
                description: "${widget.questionModel.option1}",
                correctAnswer: widget.questionModel.correctAnswer,
                optionSelected: optionSelected,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctAnswer) {

                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: OptionTile(
                option: "B",
                description: "${widget.questionModel.option2}",
                correctAnswer: widget.questionModel.correctAnswer,
                optionSelected: optionSelected,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctAnswer) {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: OptionTile(
                option: "C",
                description: "${widget.questionModel.option3}",
                correctAnswer: widget.questionModel.correctAnswer,
                optionSelected: optionSelected,
              ),
            ),
          ),
          TextButton(

            onPressed: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctAnswer) {

                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct+1 ;
                    _notAttempted = _notAttempted + 1;
                    setState(() {});
                } else {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: SingleChildScrollView(scrollDirection:Axis.horizontal ,
              child: OptionTile(
                option: "D",
                description: "${widget.questionModel.option4}",
                correctAnswer: widget.questionModel.correctAnswer,
                optionSelected: optionSelected,
              ),
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
    correctAnswer: questionSnapshot.data()["option1"] ?? "",
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
