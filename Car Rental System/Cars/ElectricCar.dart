import 'Car.dart';

class ElectricCar extends Car {
  int chargeCapacity;
  int chargingFees;
  bool charged;

  ElectricCar({
    required int year,
    required double rentPriceAday,
    required bool available,
    required this.chargeCapacity,
    this.chargingFees = 0,
    this.charged = false,
  }) : super(year, rentPriceAday, available);

  @override
  void displayCarDetails() {
    super.displayCarDetails();
    print("Battery Life: $chargeCapacity");
  }

  @override
  double calcCost(double days) {
    return super.calcCost(days) + chargingFees;
  }
}
