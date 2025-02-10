import 'package:uuid/uuid.dart';
import '../Bookings/Booking.dart';
import '../Cars/Car.dart';

// leeh 3mlt invoice abstract class w 3mlt inherit :
// 34an 7rfyn satr wa7ed , w hwa el fees ( swa2 kanet el charging aw el luxury fees )
// le 2n lw kont 3mltha b if's kanet htwl awy elly hwa , if car is electric , apply charging fees , if  msh 3arf eh do msh 3arf eh
// w brdw el 3mlt one big invoice w 7tyt feh kol el fees w elly msh m7tago gnbo 0$ , mknt4 htb2a latyfa brdw
// fa 2olt a3ml invoice for each type of car
// w lma agy a3ml booking 3momn , all I need to do is booking.creatInvoice , I don't have to check for the type of booking or car , it just does it.


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
