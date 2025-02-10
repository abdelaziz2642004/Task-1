import 'package:uuid/uuid.dart';

import '../Cars/Car.dart';
import '../Cars/ElectricCar.dart';
import '../Cars/SportsCar.dart';
import '../Customers/Customer.dart';

class Booking {
  String id;
  Customer customer;
  Car car;
  DateTime startDate;
  DateTime endDate;
  Duration duration;
  double totalCost = 0.0;
  double lateReturnFees = 0.0;

  Booking({
    required this.customer,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.lateReturnFees,
  })  : id = Uuid().v4(),
        duration = endDate.difference(startDate);

  void calculateTotalCost() {
    totalCost = car.calcCost(duration.inDays.toDouble());
  }

  void displayBookingDetails() {
    print("Booking ID: $id");
    print("Customer: ${customer.name}");
    print("Car ID: ${car.id}");
    print("Type: ${car.runtimeType}");
    print("Start Date: $startDate");
    print("End Date: $endDate");
    print("Duration: ${duration.inDays} days");
    String type = car.runtimeType.toString();
    print("rent per day: ${car.rentPriceAday}");
    if (type == "ElectricCar") {
      print("Charging Fees: \$${(car as ElectricCar).chargingFees}");
    } else if (type == "SportsCar") {
      print("luxury Fees: \$${(car as SportsCar).luxuryFees}");
    }
    print("Total Cost: $totalCost");
    print("Late Return Fees per day: $lateReturnFees");
    print("-----------------------------------");
  }
}
