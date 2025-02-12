import 'dart:io';

import '../Bookings/Booking.dart';
import '../Bookings/ElectricCarBooking.dart';
import '../Customers/Customer.dart';
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

  @override
  Booking createBooking({
    required Customer customer,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  }) {
    bool change = false;
    while (true) {
      stdout.write("Do you want to charge the Car or not? (Y/N): ");
      String? choice = stdin.readLineSync()?.toLowerCase();
      if (choice == "y") {
        change = true;
        break;
      } else if (choice == "n") break;
      print("Invalid choice. Enter 'Y' or 'N'.");
    }
    return ElectricCarBooking(
        customer: customer,
        car: this,
        startDate: startDate,
        endDate: endDate,
        lateReturnFees: lateReturnFees,
        chargeCar: change);
  }

  double get chargeCapacity => _chargeCapacity;
  double get chargingFees => _chargingFees;
}
