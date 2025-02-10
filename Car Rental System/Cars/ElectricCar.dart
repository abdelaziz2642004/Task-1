import 'Car.dart';

class ElectricCar extends Car {
  double _chargeCapacity;
  double _chargingFees;

  ElectricCar({
    required int year,
    required double rentPriceAday,
    required bool available,
    required double chargeCapacity,
    double chargingFees = 0,
  })  : _chargeCapacity = chargeCapacity,
        _chargingFees = chargingFees,
        super(year, rentPriceAday, available);

  @override
  void displayCarDetails() {
    super.displayCarDetails();
    print("Battery Life: $_chargeCapacity");
  }

  @override
  double calcCost(double days) => super.calcCost(days) + _chargingFees;

  double get chargeCapacity => _chargeCapacity;
  double get chargingFees => _chargingFees;
}
