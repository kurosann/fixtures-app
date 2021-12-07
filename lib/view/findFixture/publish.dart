import 'package:flutter/cupertino.dart';

class PublishPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Publish();

}

class Publish extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("发布需求"),
        ),
        child: Container()
    );
  }
}