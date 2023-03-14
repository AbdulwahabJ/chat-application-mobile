// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constent.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  static String id = 'LogINScreen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //
  String? email;
  String? password;
  //
  bool? Isloding = false;
  GlobalKey<FormState> formKey = GlobalKey();
  //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Isloding!,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75),

                Image.asset(
                  kLogo,
                  height: 120,
                ),
                //
                Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 70),

                Row(
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                //
                //sized
                SizedBox(height: 8),

                const SizedBox(height: 10),
                CustomFormTextField(
                    textHint: 'Email',
                    onChanged: (email) {
                      this.email = email;
                    }),
                //sized
                const SizedBox(height: 15),
                CustomFormTextField(
                    Obscure: true,
                    textHint: 'password',
                    onChanged: (password) {
                      this.password = password;
                    }),
                //sized
                const SizedBox(height: 20),

                CustomButton(
                  text: 'Login',
                  onTap: () async {
                    bool cheak = true;

                    if (formKey.currentState!.validate()) {
                      Isloding = true;
                      setState(() {});

                      try {
                        await LogInUSer();
                        Navigator.pushNamed(context, ChatScreen.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        cheak = false;
                        //displying error on user screen using snackmessenger..
                        if (e.code == 'weak-password') {
                          snackBar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          snackBar(
                              context, 'email already exsist try to log in');
                        } else {
                          snackBar(context, 'null');
                        }
                      }
                      Isloding = false;
                      setState(() {});
                      // cheak if user sign up to display success message..
                    }
                  },
                ),
                //
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFFC7EDE6)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LogInUSer() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
