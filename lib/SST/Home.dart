import 'package:flutter/material.dart';
import 'package:learn/dashboard/QNA.dart';
import 'package:learn/dashboard/student/subject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SSTi extends StatefulWidget {
  const SSTi({Key? key}) : super(key: key);

  @override
  State<SSTi> createState() => _HomeState();
}

class _HomeState extends State<SSTi> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> quizStream;
  final DatabaseServices databaseServices = DatabaseServices();

  @override
  void initState() {
    super.initState();
    _initializeQuizStream();
  }

  Future<void> _initializeQuizStream() async {
    setState(() {
      quizStream = databaseServices.getQuizData();
    });
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
        elevation: 4,
        shadowColor: Colors.blue,
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Text(
              "Quiz",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: quizStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index].data();
                final title = data?["quizTitle"] ?? "";
                if (title == "SST") {
                  return QuizTile(
                    Number: data?["quizNumber"] ?? "",
                    Title: title,
                    Description: data?["quizDescription"] ?? "",
                    quizId: data?["quizId"] ?? "",
                  );
                } else {
                  // Handle cases where the title is not "SST"
                  return Container(); // or any other widget you want to return
                }
              },

            );
          }
        },
      ),
    );
  }
}

Future<void> clearLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn');
}

class QuizTile extends StatelessWidget {
  final String Number;
  final String Title;
  final String Description;
  final String quizId;

  const QuizTile({
    required this.Number,
    required this.Title,
    required this.Description,
    required this.quizId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizId)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.blue.withOpacity(1),
        color: Colors.yellowAccent,
        margin: EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Number,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                Title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 8),
              Text(
                Description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,),),],),),),);
  }
}

class DatabaseServices {
  Stream<QuerySnapshot<Map<String, dynamic>>> getQuizData() {
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }
}
