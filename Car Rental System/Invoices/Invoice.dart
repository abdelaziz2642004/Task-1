import 'package:uuid/uuid.dart';
import '../Bookings/Booking.dart';
import '../Cars/Car.dart';
import '../Cars/ElectricCar.dart';
import '../Cars/SportsCar.dart';

class Invoice {
  String id;
  Booking booking;
  double baseCost = 0.0;
  double additionalFees = 0.0;
  double totalAmount = 0.0;
  DateTime returnDate = DateTime.now();

  Invoice({
    required this.booking,
    required this.returnDate,
  })  : id = Uuid().v4(),
        baseCost = booking.totalCost;

  void generateInvoice() {
    if (returnDate.isAfter(booking.endDate)) {
      additionalFees = booking.lateReturnFees *
          returnDate.difference(booking.endDate).inDays.toDouble();
    }
    totalAmount = baseCost + additionalFees;

    displayInvoice();
  }

  void displayInvoice() {
    Car car = booking.car;
    print("Invoice ID: $id");
    print("Booking ID: ${booking.id}");
    print("Customer: ${booking.customer.name}");
    print("Car ID: ${booking.car.id}, Type: ${booking.car.runtimeType}");
    String type = car.runtimeType.toString();
    print("type: $type");

    print("rent per day: ${car.rentPriceAday}");
    print("Reservation Period: ${booking.startDate} to ${booking.endDate}");
    print("Return Date: $returnDate");

    if (type == "ElectricCar") {
      print("Charging Fees: \$${(car as ElectricCar).chargingFees}");
    } else if (type == "SportsCar") {
      print("luxury Fees: \$${(car as SportsCar).luxuryFees}");
    }
    print("Base Rental Cost: \$${baseCost.toStringAsFixed(2)}");

    print(
        "Additional Fees for late return : \$${additionalFees.toStringAsFixed(2)}");
    print("Total Amount: \$${totalAmount.toStringAsFixed(2)}");
    print("-----------------------------------");
  }
}
