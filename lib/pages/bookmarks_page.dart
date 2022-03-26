import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worden/models/database/user.dart';
import 'package:worden/models/mixins/string_functions.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with StringFunctionsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<User>>(
        stream: User.getCurrentUserStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data!.data()!.bookmarks.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey.shade200,
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 10, left: 10),
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 20,
                  right: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      (index + 1).toString() + ". ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      capitalizeFirstCharacter(
                          snapshot.data!.data()!.bookmarks[index]),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          List<String> bookmarks =
                              snapshot.data!.data()!.bookmarks;

                          bookmarks
                              .remove(snapshot.data!.data()!.bookmarks[index]);

                          snapshot.data!.reference
                              .set(User(bookmarks: bookmarks));
                        },
                        child: const Icon(CupertinoIcons.clear_circled))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
