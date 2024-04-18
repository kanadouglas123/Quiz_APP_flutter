import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn/views/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.yellowAccent,
        title: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: false,
                          textInputAction: TextInputAction.next,
                          decoration:
                          InputDecoration(
                            border: InputBorder.none,
                              hintText: "Enter your email here"),
                          controller: _email,
                          cursorColor: Colors.red,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                              hintText: "Enter your password here"),
                          cursorColor: Colors.red,
                          controller: _password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Card(
                      color: Colors.yellowAccent,
                      shadowColor: Colors.black26,
                      child: TextButton(
                        onPressed: () async {
                          if (_email.text.isNotEmpty &&
                              _password.text.isNotEmpty) {
                            try {
                              // Show circular progress indicator
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              final userCredential =
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _email.text,
                                password: _password.text,
                              );
                              // Clear text fields after successful registration
                              _email.clear();
                              _password.clear();
                              // Dismiss the circular progress indicator dialog
                              Navigator.pop(context);
                              // Show snackbar message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Account created successfully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              // Handle registration errors here
                              print(e.message);
                              // Dismiss the circular progress indicator dialog
                              Navigator.pop(context);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all fields'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      "Already have an account",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              );
            default:
              return Center(child: Text("Loading.."));
          }
        },
      ),

    );
  }
}
