import 'Car.dart';

class EconomyCar extends Car {
  EconomyCar({
    required int year,
    required double rentPriceAday,
    required bool available,
  }) : super(year, rentPriceAday, available);
}
