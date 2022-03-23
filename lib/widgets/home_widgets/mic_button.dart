import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicButton extends StatefulWidget {
  const MicButton({Key? key, required this.onRecognition}) : super(key: key);
  final Function(String) onRecognition;
  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  late bool isSelected;
  late SpeechToText speechToText;
  @override
  void initState() {
    isSelected = false;
    speechToText = SpeechToText()..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      repeat: true,
      color: Colors.orange.shade800,
      minRadius: 35,
      ripplesCount: isSelected ? 7 : -2,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isSelected = true;
          });
          SpeechToText speechToText = SpeechToText();
          await speechToText.initialize(
            onStatus: (status) {
              if (status == 'done') {
                setState(() {
                  isSelected = false;
                });
              }
            },
            onError: (error) {},
            debugLogging: true,
          );
          speechToText.listen(
            onResult: (result) {
              widget.onRecognition(result.recognizedWords);
            },
            listenMode: ListenMode.search,
          );
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(isSelected ? 0 : 10),
          shape: MaterialStateProperty.all(
            const CircleBorder(),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(25),
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.orange.shade800,
          ),
        ),
        child:
            Icon(Icons.mic, size: MediaQuery.of(context).size.height * 0.035),
      ),
    );
  }
}
