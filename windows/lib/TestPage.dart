import 'dart:io';

import 'package:flutter/material.dart';
import 'package:windows/TestConstructor.dart';

class TestPage extends StatelessWidget {
  //Main page of test question
  const TestPage({Key? key, required this.constructor, required this.pageIndex})
      : super(key: key);

  final TestConstructor constructor;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Put question into appBar
        appBar: AppBar(
          title: Text(constructor.questions[pageIndex][0]),
        ),
        //Answers and attachment into body
        body: QuestionBody(constructor, pageIndex));
  }
}

class QuestionBody extends StatefulWidget {
  //Widget for body, because it uses RadioButton and
  //changes its own state, I make it Stateful
  const QuestionBody(this.constructor, this.pageIndex, {Key? key})
      : super(key: key);

  final TestConstructor constructor;
  final int pageIndex;

  @override
  State<StatefulWidget> createState() => _QuestionBody(constructor, pageIndex);
}

class _QuestionBody extends State<QuestionBody> {
  _QuestionBody(this.constructor, this.pageIndex);

  int value = -1;
  final TestConstructor constructor;
  final int pageIndex;

  //"Body" of answers
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            //Check for image and add if exists
            child: constructor.attachments[pageIndex] == "NONE"
                ? Container()
                : Image.file(File(constructor.imagePath +
                    constructor.attachments[pageIndex]))),
        Center(
          child: Text(
            "Варианты ответа",
            style: TextStyle(fontSize: 25),
          ),
        ),
        //Construct a list of RadioButtons to choose answer
        ListView.builder(
            itemCount: constructor.choices,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RadioListTile(
                  title: Text(constructor.questions[pageIndex][index + 1]),
                  value: index,
                  groupValue: value,
                  //change state if RadioButton is pressed
                  onChanged: (ind) => setState(() {
                        constructor.selectedIndexes[pageIndex] = ind as int;
                        value = ind;
                        //check if question is last and move forward
                        pageIndex < constructor.amount - 1
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TestPage(
                                      constructor: constructor,
                                      pageIndex: pageIndex + 1,
                                    )))
                            //TODO: add results screen
                            : print("END OF TEST");
                      }));
            })
      ],
    );
  }
}
