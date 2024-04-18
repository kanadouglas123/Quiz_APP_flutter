import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn/dashboard/opening.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const First(),
    );
  }
}

class First extends StatefulWidget {
  const First({Key? key});

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        title: const Text(
          "Quiz",
          style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: QuizDashboard(),


    );
  }
}
