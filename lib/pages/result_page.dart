import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worden/models/database/dictionary.dart';
import 'package:worden/models/database/dictionary_response.dart';
import 'package:worden/models/database/word.dart';
import 'package:worden/models/mixins/database.dart';
import 'package:worden/models/mixins/string_functions.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.response}) : super(key: key);
  final DictionaryResponse response;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with StringFunctionsMixin, DatabaseMixin {
  late TextEditingController controller;
  late DictionaryResponse response;
  late bool loading;
  @override
  void initState() {
    response = widget.response;
    loading = false;
    controller = TextEditingController(
      text: capitalizeFirstCharacter(response.word.value),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: getBookmarksStream(),
        builder: (context, snapshot) {
          List<String> bookmarks = List<String>.from(
              snapshot.hasData ? snapshot.data!.get('bookmarks') : []);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (bookmarks.contains(response.word.value)) {
                  bookmarks.remove(response.word.value);
                } else {
                  bookmarks.add(response.word.value);
                }
                await snapshot.data!.reference.update({
                  "bookmarks": bookmarks,
                });
              },
              child: bookmarks.contains(response.word.value)
                  ? const Icon(Icons.bookmark_added)
                  : const Icon(Icons.bookmark_add),
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
                : DefaultTabController(
                    length: 4,
                    child: Column(
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, right: 20),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.arrow_back_ios),
                                ),
                                Expanded(
                                  child: CupertinoSearchTextField(
                                    controller: controller,
                                    onSubmitted: (word) async {
                                      if (word.toLowerCase() ==
                                          response.word.value.toLowerCase()) {
                                        return;
                                      }
                                      setState(() {
                                        loading = true;
                                      });
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      DictionaryResponse result =
                                          await Dictionary.search(
                                              Word(word.trim()));
                                      setState(() {
                                        loading = false;
                                        response = result;
                                      });
                                    },
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15, left: 5),
                                    prefixInsets:
                                        const EdgeInsets.only(left: 10),
                                    suffixInsets:
                                        const EdgeInsets.only(right: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TabBar(
                          tabs: const [
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Text('Definitions'),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Text('Synonyms'),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Text('Antonyms'),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Text('Examples'),
                              ),
                            ),
                          ],
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          automaticIndicatorColorAdjustment: true,
                          labelColor: Colors.black,
                          isScrollable: true,
                          indicatorColor: Colors.orange.shade800,
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelColor: Colors.grey.shade600,
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          overlayColor:
                              MaterialStateProperty.all(Colors.orange.shade100),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                itemCount: response.definitions.length,
                                padding: const EdgeInsets.only(top: 20),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 10),
                                    child: Card(
                                      elevation: 10,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              capitalizeFirstCharacter(response
                                                  .definitions[index]
                                                  .partsOfSpeech),
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              capitalizeFirstCharacter(
                                                response.definitions[index]
                                                    .definition,
                                              ),
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: response.synonyms.length,
                                padding: const EdgeInsets.only(top: 20),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 10),
                                    child: Card(
                                      elevation: 10,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (index + 1).toString() + ". ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              capitalizeFirstCharacter(
                                                response.synonyms[index],
                                              ),
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey.shade900,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: response.antonyms.length,
                                padding: const EdgeInsets.only(top: 20),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 10),
                                    child: Card(
                                      elevation: 10,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (index + 1).toString() + ". ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              capitalizeFirstCharacter(
                                                response.antonyms[index],
                                              ),
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey.shade900,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: response.examples.length,
                                padding: const EdgeInsets.only(top: 20),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 10),
                                    child: Card(
                                      elevation: 10,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (index + 1).toString() + ". ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                capitalizeFirstCharacter(
                                                  response.examples[index],
                                                ),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey.shade900,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
