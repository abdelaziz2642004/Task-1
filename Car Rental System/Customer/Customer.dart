import 'package:uuid/uuid.dart';
import '../Bookings/Booking.dart';

class Customer {
  final String id;
  String _email;
  String _name;
  String _phone;
  String _address;
  String _password;
  final List<Booking> _bookingHistory;
  final List<Booking> _OngoingBookings;

  Customer({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    List<Booking>? bookingHistory,
    List<Booking>? OngoingBookings,
  })  : id = Uuid().v4(),
        _name = name,
        _email = email,
        _phone = phone,
        _address = address,
        _bookingHistory = bookingHistory ?? [],
        _OngoingBookings = OngoingBookings ?? [],
        _password = password;

  String get name => _name;
  set name(String value) => _name = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get phone => _phone;
  set phone(String value) => _phone = value;

  String get address => _address;
  set address(String value) => _address = value;

  String get password => _password;
  set password(String value) => _password = value;

  List<Booking> get bookingHistory => _bookingHistory;
  List<Booking> get OngoingBookings => _OngoingBookings;

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
    _OngoingBookings.add(booking);
  }

  void removeBooking(Booking booking) {
    _OngoingBookings.remove(booking);
  }
}
