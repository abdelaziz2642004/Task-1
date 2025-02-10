import 'package:uuid/uuid.dart';
import '../Bookings/Booking.dart';
import '../Cars/Car.dart';

abstract class Invoice {
  String _id;
  Booking _booking;
  double _baseCost = 0.0; // without luxury or charging fees
  double _additionalFees = 0.0;
  double _totalAmount = 0.0;
  DateTime _returnDate = DateTime.now();

  Invoice({
    required Booking booking,
    required DateTime returnDate,
  })  : _id = Uuid().v4(),
        _booking = booking,
        _returnDate = returnDate,
        _baseCost =
            booking.car.rentPriceAday * booking.duration.inDays.toDouble();

  void calcAdditionalFees() {
    if (_returnDate.isAfter(_booking.endDate)) {
      _additionalFees = _booking.lateReturnFees *
          _returnDate.difference(_booking.endDate).inDays.toDouble();
    }
    _totalAmount = _baseCost + _additionalFees;
  }

  void generateInvoice() {
    Car car = _booking.car;
    print("Invoice ID: $_id");
    print("Booking ID: ${_booking.id}");
    print("Customer: ${_booking.customer.name}");
    print("Car ID: ${_booking.car.id}");
    String type = car.runtimeType.toString();
    print("type: $type");

    print("rent per day: ${car.rentPriceAday}");
    print("Late fees per day: ${_booking.lateReturnFees}");

    print("Reservation Period: ${_booking.startDate} to ${_booking.endDate}");
    print("Return Date: $_returnDate");

    // Getters
  }

  String get id => _id;
  Booking get booking => _booking;
  double get baseCost => _baseCost;
  double get additionalFees => _additionalFees;
  double get totalAmount => _totalAmount;
  DateTime get returnDate => _returnDate;
  set totalAmount(double value) => _totalAmount = value;
}
