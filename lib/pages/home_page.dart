import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:worden/models/database/cache.dart';
import 'package:worden/models/database/dictionary.dart';
import 'package:worden/models/database/dictionary_response.dart';
import 'package:worden/models/database/word.dart';
import 'package:worden/models/exception/api_exception.dart';
import 'package:worden/pages/auth_page.dart';
import 'package:worden/pages/profile_page.dart';
import 'package:worden/pages/result_page.dart';
import 'package:worden/widgets/home_widgets/mic_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool loading;
  late TextEditingController controller;
  @override
  void initState() {
    loading = false;
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      'assets/default_user_image.png',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ??
                        'Username',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email ??
                        "example@gmail.com",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ProfilePage();
                  },
                ));
              },
            ),
            ListTile(
              title: const Text(
                'Bookmarks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.bookmarks_outlined,
                color: Colors.black,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Alert"),
                      content: const Text('Are you sure you want to sign out?'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Okay"),
                          isDestructiveAction: true,
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AuthPage();
                                },
                              ),
                            );
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          isDefaultAction: true,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: loading
          ? Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.orange.shade800,
                    strokeWidth: 2,
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    "Loading . . .",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Image.asset(
                    "assets/home_bg_1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "Thesaurus",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Find synonyms, antonyms, and related words.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CupertinoSearchTextField(
                      controller: controller,
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        right: 10,
                        left: 10,
                      ),
                      onSubmitted: (String word) async {
                        try {
                          setState(() {
                            loading = true;
                          });
                          DictionaryResponse responses =
                              await Dictionary.search(Word(word.trim()));
                          await Future.delayed(
                              const Duration(milliseconds: 800));
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ResultPage(response: responses);
                              },
                            ),
                          );
                          setState(() {
                            loading = false;
                          });
                        } on ApiException catch (e) {
                          Fluttertoast.showToast(msg: e.message);
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      prefixInsets: const EdgeInsets.only(left: 15),
                      suffixInsets: const EdgeInsets.only(right: 15),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  MicButton(
                    onRecognition: (words) {
                      controller.text = words;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                ],
              ),
            ),
    );
  }
}
