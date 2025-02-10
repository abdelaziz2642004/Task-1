// the same if electric car is selected, the user will be asked if they want to charge the car or not and
//the invoice will include the charging fees if they did and cancel them if not :D

import '../Bookings/Booking.dart';
import '../Bookings/ElectricCarBooking.dart';
import '../Cars/ElectricCar.dart';
import 'Invoice.dart';

class ElectricCarInvoice extends Invoice {
  ElectricCarInvoice({
    required Booking booking,
    required DateTime returnDate,
  }) : super(booking: booking, returnDate: returnDate);

  @override
  void generateInvoice() {
    super.generateInvoice();

    bool used = (booking as ElectricCarBooking).chargeCar;
    calcAdditionalFees();
    print(
        "Charging Fees: \$${used ? (booking.car as ElectricCar).chargingFees : 0}");
    print("Base Rental Cost: \$$baseCost");

    print(
        "Additional Fees for late return : \$${additionalFees.toStringAsFixed(2)}");
    print("Total Amount: \$${totalAmount}");
    print("-----------------------------------");
  }

  @override
  void calcAdditionalFees() {
    super.calcAdditionalFees();
    if ((booking as ElectricCarBooking).chargeCar)
      totalAmount += (booking.car as ElectricCar).chargingFees;
  }
}
