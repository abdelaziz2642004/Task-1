// I created this class to handle whether the user wants to charge the car or not and
// include that in the invoice. without anyinteraction with the car object it self

import '../Cars/Car.dart';
import '../Cars/ElectricCar.dart';
import '../Customer/Customer.dart';
import '../Invoices/ElectricCarInvoice.dart';
import '../Invoices/Invoice.dart';
import 'Booking.dart';

class ElectricCarBooking extends Booking {
  final bool chargeCar;

  ElectricCarBooking({
    required Customer customer,
    required Car car,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
    required this.chargeCar,
  }) : super(
            customer: customer,
            car: car,
            startDate: startDate,
            endDate: endDate,
            lateReturnFees: lateReturnFees);

  @override
  void displayBookingDetails() {
    super.displayBookingDetails();
    print("rent per day: ${car.rentPriceAday}");
    if (chargeCar) {
      print("Charging Fees: \$${(car as ElectricCar).chargingFees}");
    }
    print("Total Cost: $totalCost");
    print("-----------------------------------");
  }

  @override
  void calculateTotalCost() {
    super.calculateTotalCost();
    if (!chargeCar) {
      totalCost -= (car as ElectricCar).chargingFees;
    }
  }

  @override
  Invoice createInvoice(DateTime returnDate) =>
      ElectricCarInvoice(booking: this, returnDate: returnDate);
}
