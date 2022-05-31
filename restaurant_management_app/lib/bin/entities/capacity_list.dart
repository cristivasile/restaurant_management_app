import 'package:restaurant_management_app/bin/services/capacity_service.dart';

CapacityList? object;

class CapacityList {
  late List<int> _capacities;
  CapacityList._();

  static Future<void> loadCapacityList() async {
    if(object == null){
      object = CapacityList._();
      object!._capacities = await loadCapacities();
    }
  }

  static List<int> getCapacityList() {
    object ??= CapacityList._();

    return object!._capacities;
  }


  static void setCapacities(List<int> newTables){
    object ??= CapacityList._();
    object!._capacities = newTables;
  }
}
