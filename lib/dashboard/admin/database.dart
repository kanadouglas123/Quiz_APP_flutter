import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  late QuerySnapshot questionsSnapshot;
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    try {
      await FirebaseFirestore.instance.collection("Quiz").doc(quizId).set(quizData);
    } catch (e) {
      print("Error adding quiz data: $e");
    }
  }

  Future<void> addQuestionData(Map<String, dynamic> questionData, String quizId) async {
    try {
      await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").add(questionData);
    } catch (e) {
      print("Error adding question data: $e");
    }
  }

  Stream<QuerySnapshot> getQuizData(String quizId) {
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getQNA(String quizId) async {
    try {
      return await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").snapshots();
    } catch (e) {
      print("Error fetching QNA data: $e");
      return null;
    }
  }
}

void example() async {
  DatabaseService database = DatabaseService();
  Stream<QuerySnapshot<Map<String, dynamic>>>? result = await database.getQNA("quizId");
  if (result != null) {
    // Process the query result
  } else {
    print("Failed to fetch QNA data");
  }
}
