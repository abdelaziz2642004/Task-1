import 'package:uuid/uuid.dart';

import '../Cars/Car.dart';
import '../Customers/Customer.dart';
import '../Invoices/Invoice.dart';

// tyb leeh 3mlt el booking abstract w inheritance brdo ? be kol bsata 34an 7aga wa7da mostfza esmha "Charging fees IF USED"
// fa dh m3nah en msh kol booking zy el tany
// fe booking hy7tag y3rf somehow eza kan tm charging wla la2
// w fe el most2bl mmkn a7tag features aktr for each car brdo
// fa decided to make it abstract and inherit from it

abstract class Booking {
  String _id;
  Customer _customer;
  Car _car;
  DateTime _startDate;
  DateTime _endDate;
  Duration _duration;
  double _totalCost = 0.0;
  double _lateReturnFees = 0.0;

  Booking({
    required Customer customer,
    required Car car,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  })  : _customer = customer,
        _car = car,
        _startDate = startDate,
        _endDate = endDate,
        _lateReturnFees = lateReturnFees,
        _id = Uuid().v4(),
        _duration = endDate.difference(startDate);

  void calculateTotalCost() {
    _totalCost = _car.calcCost(_duration.inDays.toDouble());
  }

  void displayBookingDetails() {
    print("Booking ID: $_id");
    print("Customer: ${_customer.name}");
    print("Car ID: ${_car.id}");
    print("Type: ${_car.runtimeType}");
    print("Start Date: $_startDate");
    print("End Date: $_endDate");
    print("Duration: ${_duration.inDays} days");
    print("Total Cost: $_totalCost");
    print("Late Return Fees per day: $_lateReturnFees");
    print("-----------------------------------");
  }

  Invoice createInvoice(DateTime returnDate);

  String get id => _id;
  Customer get customer => _customer;
  Car get car => _car;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  Duration get duration => _duration;
  double get totalCost => _totalCost;
  double get lateReturnFees => _lateReturnFees;
  set totalCost(double value) => _totalCost = value;
}
