import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/entities/table_list.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';

import '../models/reservation_model.dart';
import '../services/reservation_service.dart';

ReservationList? object;

class ReservationList {
  late List<ReservationModel> _Reservations;
  ReservationList._();

  static Future<void> loadReservationList() async {
    if (object == null) {
      object = ReservationList._();
      object!._Reservations = await loadReservations();
    }
  }

  static List<ReservationModel> getReservationList() {
    object ??= ReservationList._();

    return object!._Reservations;
  }

  static Future<List<TableModel>> getFreeTables() async {
    List<TableModel> tableList = await TableList.getTableList();
    List<TableModel> freeTables = [];
    Set<String> reservedTables = {};

    for (ReservationModel reservation in object!._Reservations) {
      reservedTables.add(reservation.tableId);
    }

    for (TableModel table in tableList) {
      if (reservedTables.contains(table.id)) {
        continue;
      } else {
        freeTables.add(table);
      }
    }

    return freeTables;
  }

  static Future<List<String>> getFreeTableIds() async {
    List<TableModel> tableList = await TableList.getTableList();
    List<String> freeTableIds = [];
    Set<String> reservedTables = {};

    for (ReservationModel reservation in object!._Reservations) {
      reservedTables.add(reservation.tableId);
    }

    for (TableModel table in tableList) {
      if (reservedTables.contains(table.id)) {
        continue;
      } else {
        freeTableIds.add(table.id);
      }
    }

    return freeTableIds;
  }

  static Future<bool> checkValidReservation(
      ReservationModel reservation) async {
    List<String> freeTableIds = await getFreeTableIds();

    if (!freeTableIds.contains(reservation.tableId)) {
      return false;
    }

    //aici teoretic trebuie sa verific pentru disponibilitatea mesei dupa data si ora
    DateTime dt = reservation.dateTime;
    for (ReservationModel res in object!._Reservations) {
      DateTime resDT = res.dateTime;
    }
    return true;
  }

  static void setReservationList(List<ReservationModel> newTables) {
    object ??= ReservationList._();
    object!._Reservations = newTables;
  }

  static void addReservation(ReservationModel Reservation) async {
    bool validReservation = await checkValidReservation(Reservation);
    if (validReservation) {
      object ??= ReservationList._();
      object!._Reservations.add(Reservation);
    } else {
      //invalid reservation
    }
  }

  ///Removes a Reservation with a given name
  static void removeReservationByName(String ReservationName) {
    object ??= ReservationList._();
    object!._Reservations.removeWhere((element) =>
        element.name.toLowerCase() == ReservationName.toLowerCase());
  }
}
