//variables that need to be loaded from disk and be visible in the whole project

import '../models/globals_model.dart';
import '../services/globals_service.dart';

Globals? object;

class Globals {
  late GlobalsModel _globals;
  Globals._();

  static Future<void> loadGlobals() async {
    if(object == null){
      object = Globals._();
      object!._globals = await loadGlobalObject();
    }
  }

  static GlobalsModel getGlobals() {
    object ??= Globals._();

    return object!._globals;
  }

}
