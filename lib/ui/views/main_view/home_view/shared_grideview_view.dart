import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedGridviewView extends StatefulWidget {
  final String text;
  final Widget listOfText;

  const SharedGridviewView({
    Key? key,
    required this.text,
    required this.listOfText,
  }) : super(key: key);

  @override
  State<SharedGridviewView> createState() => _SharedGridviewViewState();
}

class _SharedGridviewViewState extends State<SharedGridviewView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isOnPressd = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isOnPressd = !isOnPressd;
      if (isOnPressd) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 10, horizontal: isOnPressd ? 10 : 40),
      child: AnimatedSize(
        // vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        curve: Curves.linearToEaseOut,
        child: InkWell(
          onTap: _toggleExpanded,
          child: Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.beveled(
                  BorderRadius.circular(isOnPressd ? 1 : 10)),
              depth: isOnPressd ? 1.5 : 0.6,
              intensity: 2,
              color: isOnPressd ?Colors.white : Colors.white,
            ),
            child: isOnPressd
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.rtl,
                          children: [
                            const Icon(
                              Icons.keyboard_arrow_up,
                              size: 37,
                              color: Color.fromRGBO(187, 229, 169, 1),
                            ),
                            Expanded(
                              child: Text(
                                widget.text,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.flowRounded(
                                 color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizeTransition(
                          sizeFactor: _controller,
                          child: widget.listOfText,
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 28,
                          color: Color.fromRGBO(187, 229, 169, 1),
                        ),
                        Expanded(
                          child: Text(
                            widget.text,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.flowRounded(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
