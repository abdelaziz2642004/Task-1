import '../Bookings/Booking.dart';
import '../Cars/Car.dart';
import '../Cars/SportsCar.dart';
import 'Invoice.dart';

class SportsCarInvoice extends Invoice {
  SportsCarInvoice({
    required Booking booking,
    required DateTime returnDate,
  }) : super(booking: booking, returnDate: returnDate);

  @override
  void calcAdditionalFees() {
    super.calcAdditionalFees();
    totalAmount += (booking.car as SportsCar).luxuryFees;
  }

  @override
  void generateInvoice() {
    super.generateInvoice();
    calcAdditionalFees();

    Car car = booking.car;

    if (car is SportsCar) {
      print("luxury Fees: \$${car.luxuryFees}");
    }
    print("Base Rental Cost: \$${baseCost.toStringAsFixed(2)}");

    print(
        "Additional Fees for late return : \$${additionalFees.toStringAsFixed(2)}");
    print("Total Amount: \$${totalAmount.toStringAsFixed(2)}");
    print("-----------------------------------");
  }

  // @override
  // void generateInvoice() {
  //   super.generateInvoice();
  //   totalAmount += (booking.car as SportsCar).luxuryFees;
  //   displayInvoice();
  // }
}
