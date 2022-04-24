import 'package:ct_journal/costanti.dart';
import 'package:flutter/material.dart';

class CTHomeBarIcon extends StatefulWidget {
  final IconData icon;
  final void Function()? onClick;
  const CTHomeBarIcon({Key? key, required this.icon, this.onClick}) : super(key: key);

  @override
  State<CTHomeBarIcon> createState() => _CTHomeBarIconState();
}

class _CTHomeBarIconState extends State<CTHomeBarIcon> {
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
