// I created this class to book any other type of car but electric
// this is much better than using the parent class because it will be easier to add more features :DDD
import '../Cars/Car.dart';
import '../Cars/SportsCar.dart';
import '../Customers/Customer.dart';
import '../Invoices/Invoice.dart';
import '../Invoices/SportsCarInvoice.dart';
import 'Booking.dart';

class SportsCarBooking extends Booking {
  SportsCarBooking({
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
    print("rent per day: \$${(car as SportsCar).luxuryFees}");
    print("luxury Fees: \$${(car as SportsCar).luxuryFees}");
    print("Total Cost(without late penalties): $totalCost");
    print("-----------------------------------");
  }

  @override
  Invoice createInvoice(DateTime returnDate) =>
      SportsCarInvoice(booking: this, returnDate: returnDate);
}
