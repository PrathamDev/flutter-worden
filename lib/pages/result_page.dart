import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worden/models/database/dictionary_response.dart';
import 'package:worden/models/mixins/string_functions.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.response}) : super(key: key);
  final DictionaryResponse response;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with StringFunctionsMixin {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(
      text: capitalizeFirstCharacter(widget.response.word),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                      prefixInsets: const EdgeInsets.only(left: 10),
                      suffixInsets: const EdgeInsets.only(right: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.response.definitions.length,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalizeFirstCharacter(widget
                                .response.definitions[index].partsOfSpeech),
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            capitalizeFirstCharacter(
                              widget.response.definitions[index].definition,
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
          ),
        ],
      ),
    );
  }
}
