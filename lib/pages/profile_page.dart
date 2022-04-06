import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:worden/models/database/cache.dart';
import 'package:worden/pages/auth_page.dart';
import 'package:worden/pages/bookmarks_page.dart';
import 'package:worden/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     style: ButtonStyle(
        //       shape: MaterialStateProperty.all(
        //         const CircleBorder(),
        //       ),
        //     ),
        //     child: Icon(
        //       Icons.more_vert,
        //       color:
        //           MediaQuery.of(context).platformBrightness == Brightness.light
        //               ? Colors.black
        //               : Colors.white,
        //     ),
        //   )
        // ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10, bottom: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundImage:
                      FirebaseAuth.instance.currentUser!.photoURL == null
                          ? const AssetImage(
                              'assets/default_user_image.png',
                            )
                          : NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!)
                              as ImageProvider,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: TextStyle(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return const EditProfilePage();
                            },
                          ),
                        );
                        setState(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.orange.shade800,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.grey.shade200
                : Colors.grey.shade300,
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 10,
            ),
            child: const Text(
              "Content",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Bookmarks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white70,
              ),
            ),
            minLeadingWidth: 20,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.bookmarks_outlined,
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white70,
                size: 25,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return const BookmarksPage();
                  },
                ),
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.grey.shade200
                : Colors.grey.shade300,
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 10,
            ),
            child: const Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Sign out',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white70,
              ),
            ),
            minLeadingWidth: 20,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.exit_to_app,
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white70,
                size: 25,
              ),
            ),
            onTap: () {
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
    );
  }
}
