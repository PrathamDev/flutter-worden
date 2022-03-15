import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class MicButton extends StatefulWidget {
  const MicButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  late bool isSelected;
  @override
  void initState() {
    isSelected = false;
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
        onPressed: () {
          widget.onTap();
          setState(() {
            isSelected = !isSelected;
          });
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
