import 'package:uuid/uuid.dart';
import '../Bookings/Booking.dart';

class Customer {
  String id;
  String _name;
  String _email;
  String _phone;
  String _address;
  List<Booking> _bookingHistory;

  Customer({
    required String name,
    required String email,
    required String phone,
    required String address,
    List<Booking>? bookingHistory,
  })  : id = Uuid().v4(),
        _name = name,
        _email = email,
        _phone = phone,
        _address = address,
        _bookingHistory = bookingHistory ?? []; // if null, make it empty

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  List<Booking> get bookingHistory => _bookingHistory;

  void displayCustomerInfo() {
    print("Customer ID: $id");
    print("Name: $name");
    print("Email: $email");
    print("Phone: $phone");
    print("Address: $address");
  }

  void displayBookingHistory() {
    print("Booking History:");
    for (var booking in _bookingHistory) {
      booking.displayBookingDetails();
    }
  }

  void addBooking(Booking booking) {
    _bookingHistory.add(booking);
  }
}
