import 'package:ct_journal/constants.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/models/handler_factory.dart';
import 'package:ct_journal/widgets/type_handlers/image_handler.dart';
import 'package:flutter/material.dart';

// TODO - removeLog - editLog

class CTLog extends StatelessWidget {
  final Log logData;
  final HandlerFactory hf;

  const CTLog({Key? key, required this.logData, required this.hf}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: CTLogBarSearchPadding, right: CTLogBarSearchPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hf.getHandler(logData.type).viewer.build(context, logData.data)
          ],
        ),
      ),
    );
  }
}
