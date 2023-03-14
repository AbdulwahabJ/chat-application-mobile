// ignore_for_file: unused_local_variable

import 'package:chat_app/screens/log_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constent.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //
  String? email, password;

  bool? Isloding = false;

  //
  GlobalKey<FormState> formKey = GlobalKey();

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
                const Center(
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
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                //sized
                const SizedBox(height: 10),
                CustomFormTextField(
                    onChanged: (email) {
                      this.email = email;
                    },
                    textHint: 'Email'),
                //sized
                const SizedBox(height: 15),
                CustomFormTextField(
                    onChanged: (password) {
                      this.password = password;
                    },
                    textHint: 'password'),
                //sized
                const SizedBox(height: 20),

                CustomButton(
                  text: 'sign up',
                  onTap: () async {
                    bool cheak = true;

                    if (formKey.currentState!.validate()) {
                      Isloding = true;
                      setState(() {});

                      try {
                        await RegisterUSer();
                        Navigator.pushNamed(context, ChatScreen.id);
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
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'alrady have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, LogInScreen.id);
                      },
                      child: const Text(
                        'Sign in',
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

  Future<void> RegisterUSer() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
