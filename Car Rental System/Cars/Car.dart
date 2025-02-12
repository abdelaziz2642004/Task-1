import 'package:uuid/uuid.dart';

import '../Bookings/Booking.dart';
import '../Customers/Customer.dart';

abstract class Car {
  // single responsibility  --> calcCost ( display 3adya mlha4 lazma just a print)
  String _id;
  int _year; // model ?
  double _rentPriceAday;
  bool _available;
  // BookingStrategy bookingStrategy;
  Car(
    this._year,
    this._rentPriceAday,
    this._available,
  ) : _id = Uuid().v4();

  set setAvailable(bool available) {
    _available = available;
  }

  set setRentPriceAday(double price) {
    _rentPriceAday = price;
  }

  void displayCarDetails() {
    print("Car ID: $_id");
    print("Year: $_year");
    print("Rent Price: $_rentPriceAday");
    print("Available: $_available");
  }

  double calcCost(double days) => days * _rentPriceAday;

  String get id => _id;
  int get year => _year;
  double get rentPriceAday => _rentPriceAday;
  bool get available => _available;
  set available(bool available) => _available = available;

  // this will solve the open closed principle but fuck up the single responsibility , use a strategy pattern ?

  Booking createBooking({
    required Customer customer,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  });
}
