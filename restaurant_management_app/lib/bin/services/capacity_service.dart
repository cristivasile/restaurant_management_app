import '../../main.dart';
import '../entities/capacity_list.dart';

/// Loads a list of orders, saves it to TableList and returns it
///
Future<List<int>> loadCapacities() async {
  return (await data.readCapacities());
}

///Saves orders to disk
///
void saveCapacities() {
  List<int> toSave = CapacityList.getCapacityList();
  data.writeCapacities(toSave); // use global data service to store tables
}