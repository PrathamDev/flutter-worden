import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worden/models/mixins/auth.dart';
import 'package:worden/models/ui/toast.dart';
import 'package:worden/pages/home_page.dart';
import 'package:worden/widgets/auth_widgets/auth_text_field.dart';

class SignUpTab extends StatefulWidget {
  const SignUpTab({Key? key}) : super(key: key);

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> with AuthMixin {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          opacity: 1,
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const CircleBorder(),
            ),
            overlayColor: MaterialStateProperty.all(
              Colors.grey.shade100,
            ),
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey.shade900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "Sign up",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height * 0.04,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AuthTextField(
              labelText: "Username",
              controller: userNameController,
            ),
            const SizedBox(
              height: 18,
            ),
            AuthTextField(
                labelText: "Email Address", controller: emailController),
            const SizedBox(
              height: 18,
            ),
            AuthTextField(
              labelText: "Password",
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 18,
            ),
            TextButton(
              onPressed: () async {
                try {
                  User? user = await signUp(
                      username: userNameController.text,
                      email: emailController.text,
                      password: passwordController.text);

                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  Toast.showCode(e.code);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xFFEF6C00),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.06),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              child: Text(
                "Create an Account",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
