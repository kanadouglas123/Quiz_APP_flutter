import 'package:flutter/material.dart';
import 'package:learn/dashboard/admin/show_questions.dart';
import 'package:learn/dashboard/admin/create.dart';
import 'package:learn/dashboard/admin/database.dart';
import 'package:learn/views/login.dart';
import 'package:learn/views/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Quiz",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.logout, size: 35),
            onPressed: () async {
              // Clear login status
              await clearLoginStatus();

              // Navigate to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.admin_panel_settings, size: 40),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
          ),
        ],
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
                return QuizTile(
                  Number: data?["quizNumber"] ?? "",
                  Title: data?["quizTitle"] ?? "",
                  Description: data?["quizDescription"] ?? "",
                  quizId: data?["quizId"]??"",
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        splashColor: Colors.greenAccent,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Quiz()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> clearLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn'); // Remove the isLoggedIn key
}

class QuizTile extends StatelessWidget {
  final String Number;
  final String Title;
  final String Description;

  const QuizTile({
    required this.Number,
    required this.Title,
    required this.Description,
    required this.quizId
  });
  final String quizId ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayQuiz( quizId :quizId),));
    },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 150,
        padding: EdgeInsets.all(10), // Add padding for inner content
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
          color: Colors.yellowAccent, // Set background color
          border: Border.all(color: Colors.blue, width: 2), // Add border
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Number,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      Title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _delete(quizId);

                        print("Your deleting me please");
                      },
                        child: Icon(Icons.delete, size: 30, color: Colors.redAccent,)),
                  ],)],),
            SizedBox(height: 25,),
            Text(
              Description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),),],),),
    );}

  void _delete(String quizId) {
    final Quiz=FirebaseFirestore.instance.collection("Quiz");
    Quiz.doc(quizId).delete();
  }}

class DatabaseServices {
  Stream<QuerySnapshot<Map<String, dynamic>>> getQuizData() {
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }
}
