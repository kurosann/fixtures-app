import 'package:flutter/cupertino.dart';

class EmptyAppBar extends StatelessWidget implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context) => Container();

  @override
  Size get preferredSize => Size(0.0, 0.0);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

}