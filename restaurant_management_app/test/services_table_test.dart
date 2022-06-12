import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_management_app/bin/services/table_service.dart';

void main() {
  
  test('getTableLetterFromSize valid table size 2', () {
    var result = getTableLetterFromSize(2);
    expect(result, 'A');
  });

  test('getTableLetterFromSize valid table size 3', () {
    var result = getTableLetterFromSize(3);
    expect(result, 'B');
  });

  test('getTableLetterFromSize valid table size 4', () {
    var result = getTableLetterFromSize(4);
    expect(result, 'C');
  });

  test('getTableLetterFromSize valid table size 6', () {
    var result = getTableLetterFromSize(6);
    expect(result, 'D');
  });

  test('getTableLetterFromSize valid table size 8', () {
    var result = getTableLetterFromSize(8);
    expect(result, 'E');
  });

  test('getTableLetterFromSize invalid table size', () {
    expect(() => getTableLetterFromSize(1), throwsA(isInstanceOf<Exception>()));
  });

}
