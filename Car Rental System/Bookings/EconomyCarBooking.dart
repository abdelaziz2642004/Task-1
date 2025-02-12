import '../Cars/Car.dart';
import '../Customers/Customer.dart';
import '../Invoices/EconomyCarInvoice.dart';
import '../Invoices/Invoice.dart';
import 'Booking.dart';

class EconomyCarBooking extends Booking {
  EconomyCarBooking({
    required Customer customer,
    required Car car,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  }) : super(
          customer: customer,
          car: car,
          startDate: startDate,
          endDate: endDate,
          lateReturnFees: lateReturnFees,
        );

  @override
  void displayBookingDetails() {
    super.displayBookingDetails();
    print("rent per day: ${car.rentPriceAday}");
    print("Total Cost: $totalCost");
    print("-----------------------------------");
  }

  @override
  Invoice createInvoice(DateTime returnDate) =>
      EconomyCarInvoice(booking: this, returnDate: returnDate);
}
