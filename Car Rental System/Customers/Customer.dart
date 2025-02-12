import 'package:uuid/uuid.dart';
import '../Bookings/Booking.dart';

class Customer {
  String id;
  String _name;
  String _email;
  String _phone;
  String _address;
  String _password;
  List<Booking> _bookingHistory;
  List<Booking> _OngoingBookings;

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
  // if null, make it empty

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  String get password => _password;

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
