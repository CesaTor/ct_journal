import 'package:ct_journal/widgets/type_handlers/type_handler.dart';

class HandlerFactory {

  List<TypeHandler> handlers = [];

  HandlerFactory({required this.handlers});

  List<TypeHandler> getHandlers() {
    return handlers;
  }

  TypeHandler getHandler(String logType) {
    // Check logType
    if(logType.isEmpty){
      throw Exception("LogFactory.getHandler() - passed empty logType");
    }
    for(var t in handlers) {
      if(t.getType() == logType){
        return t;
      }
    }
    throw Exception("LogFactory.getHandler() - no handler found for LogType: [$logType]");
  }
}
