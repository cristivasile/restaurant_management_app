import 'package:restaurant_management_app/bin/models/globals_model.dart';

import '../../main.dart';
import '../constants.dart';
import '../entities/globals.dart';

/// Loads a list of orders, saves it to TableList and returns it
///
Future<GlobalsModel> loadGlobalObject() async {
  return (await data.readGlobalObject());
}

///Saves orders to disk
///
void saveGlobalObject() {
  GlobalsModel toSave = Globals.getGlobals();
  data.writeGlobalObject(toSave); // use global data service to store tables
}

int getZoomIndex(){
  return zoomFactors.indexOf(Globals.getGlobals().tableImagesScale);
}