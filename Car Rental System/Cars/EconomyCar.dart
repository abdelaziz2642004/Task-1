import '../Bookings/Booking.dart';
import '../Bookings/EconomyCarBooking.dart';
import '../Customers/Customer.dart';
import 'Car.dart';

class EconomyCar extends Car {
  EconomyCar({
    required int year,
    required double rentPriceAday,
    required bool available,
  }) : super(year, rentPriceAday, available);

  @override
  Booking createBooking({
    required Customer customer,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  }) =>
      EconomyCarBooking(
          customer: customer,
          car: this,
          startDate: startDate,
          endDate: endDate,
          lateReturnFees: lateReturnFees);
}
