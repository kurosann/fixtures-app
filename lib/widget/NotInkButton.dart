import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotInkButton extends StatefulWidget {
  final Widget child;

  NotInkButton({required this.child});

  @override
  State<StatefulWidget> createState() => _NotInkButton(child);
}

class _NotInkButton extends State<NotInkButton> {
  Widget child;

  _NotInkButton(this.child);

  Color tapedColor = CupertinoColors.black;
  bool taped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (e) {
        setState(() {
          taped = true;
        });
      },
      onTapUp: (e) {
        setState(() {
          taped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          taped = false;
        });
      },
      child: Stack(
        children: [
          child,
          Positioned(
            child: taped
                ? Container(
                    decoration: BoxDecoration(color: tapedColor),
                    child: child,
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
