import 'package:flutter/cupertino.dart';

class xiaoqiuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
        children: [
          Stack(alignment: const Alignment(-0.1, 0.6), children: [
            Image(
              image: AssetImage('assets/111.jpg'),
              fit: BoxFit.cover,
              height: 150,
            ),
            Container(
              child: new Text('小求'),
            )
          ])
        ],
      ),
    );
  }
}