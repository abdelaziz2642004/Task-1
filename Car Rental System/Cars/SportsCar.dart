import '../Bookings/Booking.dart';
import '../Bookings/SportsCarBooking.dart';
import '../Customers/Customer.dart';
import 'Car.dart';

class SportsCar extends Car {
  double _luxuryFees;

  SportsCar({
    required int year,
    required double rentPriceAday,
    required bool available,
    required double luxuryFees,
  })  : _luxuryFees = luxuryFees,
        super(year, rentPriceAday, available);

  @override
  void displayCarDetails() {
    super.displayCarDetails();
    print("Luxury Fees: $_luxuryFees");
  }

  @override
  double calcCost(double days) => super.calcCost(days) + _luxuryFees;
  double get luxuryFees => _luxuryFees;

  @override
  Booking createBooking({
    required Customer customer,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  }) =>
      SportsCarBooking(
          customer: customer,
          car: this,
          startDate: startDate,
          endDate: endDate,
          lateReturnFees: lateReturnFees);
}
