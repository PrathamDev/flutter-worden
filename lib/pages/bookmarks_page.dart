import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worden/models/database/dictionary.dart';
import 'package:worden/models/database/dictionary_response.dart';
import 'package:worden/models/database/user.dart';
import 'package:worden/models/database/word.dart';
import 'package:worden/models/mixins/string_functions.dart';
import 'package:worden/pages/result_page.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with StringFunctionsMixin {
  @override
  void initState() {
    super.initState();
  }

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
          return snapshot.data!.data()!.bookmarks.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/no_data.png',
                    ),
                    const Text(
                      "You have no Bookmarks yet.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: snapshot.data!.data()!.bookmarks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        DictionaryResponse response = await Dictionary.search(
                            Word(snapshot.data!.data()!.bookmarks[index]));

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ResultPage(response: response);
                          },
                        ));
                      },
                      child: Container(
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

                                  bookmarks.remove(
                                      snapshot.data!.data()!.bookmarks[index]);

                                  snapshot.data!.reference
                                      .set(User(bookmarks: bookmarks));
                                },
                                child: const Icon(CupertinoIcons.clear_circled))
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
