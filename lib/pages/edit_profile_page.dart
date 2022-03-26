import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worden/models/database/user.dart' as worden;
import 'package:worden/models/mixins/database.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with DatabaseMixin {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    nameController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName,
    );
    emailController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.email,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                await updateImage();
                setState(() {});
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.15,
                backgroundImage: FirebaseAuth.instance.currentUser!.photoURL ==
                        null
                    ? const AssetImage("assets/default_user_image.png")
                    : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                        as ImageProvider,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
            child: TextField(
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
              controller: nameController,
              cursorHeight: 22,
              cursorColor: Colors.black,
              cursorRadius: const Radius.circular(50),
              obscureText: false,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                hintText: "Full Name",
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 15,
                ),
                contentPadding: const EdgeInsets.only(
                    bottom: 12, right: 15, left: 15, top: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
            child: TextField(
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
              controller: emailController,
              cursorHeight: 22,
              cursorColor: Colors.black,
              cursorRadius: const Radius.circular(50),
              obscureText: false,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                hintText: "Email",
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 15,
                ),
                contentPadding: const EdgeInsets.only(
                    bottom: 12, right: 15, left: 15, top: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: TextButton(
              onPressed: () async {
                if (nameController.text.trim() !=
                    FirebaseAuth.instance.currentUser!.displayName) {
                  await FirebaseAuth.instance.currentUser!
                      .updateDisplayName(nameController.text.trim());
                }
                if (emailController.text.trim() !=
                    FirebaseAuth.instance.currentUser!.email) {
                  await FirebaseAuth.instance.currentUser!
                      .updateEmail(emailController.text.trim());
                }
                Navigator.pop(context);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 50)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.orange.shade900),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
