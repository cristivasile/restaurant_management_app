import '../../main.dart';
import '../entities/reservation_list.dart';
import '../models/reservation_model.dart';

Future<List<ReservationModel>> loadReservations() async {
  List<ReservationModel> Reservations = await data.readReservations();
  return Reservations;
}

void saveReservations() {
  List<ReservationModel> toSave = ReservationList.getReservationList();
  data.writeReservations(toSave);
}
