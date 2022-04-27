import 'package:ct_journal/models/handler_factory.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/ct_home_bar_icon.dart';
import 'package:ct_journal/widgets/type_handlers/type_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CTHomeBar extends StatefulWidget {

  final LogCallBack addClickAction;
  final HandlerFactory handlerFactory;
  const CTHomeBar({Key? key, required this.addClickAction, required this.handlerFactory}) : super(key: key);

  @override
  State<CTHomeBar> createState() => _CTHomeBarState();
}

class _CTHomeBarState extends State<CTHomeBar> {

  late Widget inputWidget;
  late List<Widget> controllers = [];

  void initWidgets() {

    List<Widget> iws = [];
    controllers = [];

    for(var h in widget.handlerFactory.getHandlers()) {

      // TODO - make the same as others

      for(var c in h.controllers) {
        if(c.getInputWidget() != null) {
          iws.add(c.getInputWidget()!);
        }
      }

      controllers.add(_buildTypeButton(th: h));
    }


    // Input Widgets
    if(iws.isEmpty) {
      // TODO nop
      inputWidget = const Text("");
    }
    else if(iws.length == 1) {
      inputWidget = iws.first;
    } else {
      inputWidget = Column(children: iws);
    }
  }

  @override
  Widget build(BuildContext context) {

    initWidgets();
    return
      Column(
        children: [
          inputWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  _buildHBUtilityBtns(),
              // Enabled functions
              Expanded(
                  child:
                  SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: controllers,
                      )
                  )
              )
            ],
          ),
        ],
      );
  }

  Widget _buildTypeButton({required TypeHandler th}) {

    if(th.controllers.length > 1){

      List<Widget> cld = [];

      for(var c in th.controllers) {
        cld.add(
            CTHomeBarIcon(icon: c.getButtonIconData(), onClick: () async {
              widget.addClickAction(data: await c.getData(), type: th.getType());
            })
        );
      }

      return Row(
        children: cld,
      );
    }
    return CTHomeBarIcon(icon: th.controllers.first.getButtonIconData(), onClick: () async {
      widget.addClickAction(data: await th.controllers.first.getData(), type: th.getType());
    });
  }

  // TODO - search
  Widget _buildHBUtilityBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        SizedBox(width: 10,),
        CTHomeBarIcon(icon: Icons.search),
        CTHomeBarIcon(icon: Icons.tag),
      ],
    );
  }

}
