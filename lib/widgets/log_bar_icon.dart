import 'package:ct_journal/costanti.dart';
import 'package:flutter/material.dart';

class LogBarIcon extends StatefulWidget {
  final IconData icon;
  final void Function()? onClick;
  const LogBarIcon({Key? key, required this.icon, this.onClick}) : super(key: key);

  @override
  State<LogBarIcon> createState() => _LogBarIconState();
}

class _LogBarIconState extends State<LogBarIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        icon: Icon(widget.icon),
        iconSize: CTLogBarIconSize,
        onPressed: widget.onClick ?? () {},
      ),
      height: CTLogBarIconSize + 20,
      width: CTLogBarIconSize + 20,
    );
  }
}
