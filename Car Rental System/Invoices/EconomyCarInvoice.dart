import '../Bookings/Booking.dart';
import 'Invoice.dart';

class EconomyCarInvoice extends Invoice {
  EconomyCarInvoice({
    required Booking booking,
    required DateTime returnDate,
  }) : super(booking: booking, returnDate: returnDate);

  @override
  void generateInvoice() {
    super.generateInvoice();
    calcAdditionalFees();
    print("Base Rental Cost: \$${baseCost.toStringAsFixed(2)}");

    print(
        "Additional Fees for late return : \$${additionalFees.toStringAsFixed(2)}");
    print("Total Amount: \$${totalAmount.toStringAsFixed(2)}");
    print("-----------------------------------");
  }
}
