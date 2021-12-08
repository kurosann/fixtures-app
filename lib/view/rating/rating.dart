import 'package:fixtures/model/Question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RatingState();
}

class _RatingState extends State<RatingPage> {
  var rating = <Question>[
    Question(num: "1", title: "服务态度"),
    Question(num: "2", title: "工程时效"),
    Question(num: "3", title: "满意程度"),
    Question(num: "4", title: "沟通能力"),
    Question(num: "5", title: "卫生习惯"),
  ];

  var isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: "返回",
            middle: Text("评价"),
          ),
          child: ListView.builder(
            itemCount: rating.length * 2 + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index.isOdd) return Divider();
              if (index == rating.length * 2) return _submitButton();
              final i = index ~/ 2;
              return _itemCell(i);
            },
          )),
    );
  }

  Widget _submitButton() {
    return Container(
        margin: EdgeInsets.all(10),
        child: CupertinoButton.filled(
            child: Text("提交"),
            onPressed: () {
              setState(() {
                isSubmit = true;
              });
              for (var i in rating) {}
              print(rating);
            }));
  }

  Widget _itemCell(index) {
    var question = rating[index];
    var num = question.num;
    var title = question.title;
    return Column(
      children: [
        Text("$num.$title",
            style: question.ans == null && isSubmit
                ? TextStyle(color: Colors.red)
                : null),
        Row(
          children: [
            _option(index, "优秀", 0),
            Expanded(
              child: VerticalDivider(
                width: 1,
              ),
            ),
            _option(index, "满意", 1),
          ],
        ),
        Row(
          children: [
            _option(index, "一般", 2),
            Expanded(
              child: VerticalDivider(
                width: 1,
              ),
            ),
            _option(index, "差", 3),
          ],
        )
      ],
    );
  }

  Widget _option(index, optionTitle, flag) {
    var question = rating[index];
    return Container(
      child: Expanded(
        child: CheckboxListTile(
          title: Text(optionTitle,
              style: question.ans == null && isSubmit
                  ? TextStyle(color: Colors.red)
                  : null),
          value: rating[index].ans == flag,
          onChanged: (value) {
            setState(() {
              rating[index].ans = flag;
            });
          },
        ),
      ),
    );
  }

  void _alert(context) {
    showCupertinoDialog(context: context, builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text("提示"),
        content: Text("有选项未填写"),
        actions: [
          CupertinoDialogAction(child: Text("确定"))
        ],
      );
    });
  }
}
