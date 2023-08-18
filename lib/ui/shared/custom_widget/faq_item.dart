import 'package:flutter/material.dart';

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;
  final bool? chatGPtShowMessage;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer, this.chatGPtShowMessage=false,

  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        title: Text(
          widget.question,textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),  initiallyExpanded :widget.chatGPtShowMessage == true ? true : false,
        onExpansionChanged: (expanded) {
          setState(() {
            if (widget.chatGPtShowMessage == true) {
              isExpanded = true;
            }
            else {
              isExpanded = expanded;
            }
          });
        },
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: const Color.fromRGBO(187, 229, 169, 1),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(child: Text(widget.answer,textDirection: TextDirection.rtl,)),
          ),
        ],
      ),
    );
  }
}
