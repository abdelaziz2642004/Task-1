import 'Admin/Admin.dart';
import 'Bookings/Booking.dart';

import 'Cars/Car.dart';

import 'Customer/Customer.dart';

import 'DummyData/dummy.dart';
import 'Invoices/Invoice.dart';

import 'SavingReportsCode/Logic.dart';
// lesa me7tag atb2 4wyt solid tany hena brdo ( did somethings )
// problem: I solved the open closed principle , but got a single responsibility issue
// 1- creating a booking in a car
// 2- creating an invoice in a booking

// ana 3mlt invoices fe kza class 34an kol invoice fe3ln by5tlf 3n el tany fe el output bta3o
// fa 34an awry el e5tlaf dh tb3to fe txt file
// w laken brdw 3mlt excel file w 7tyt kolo m3 kolo w el zyada kan feeh 0$ , the reason I created several inherited classes :D

class CarRentalSystem with dummy, ReportLogic {
  late final List<Customer> _customers;
  late final List<Car> _cars;
  late final List<Admin> _admins;

  final List<Booking> _bookings;
  final List<Invoice> _invoices;

  List<Customer> get customers => _customers;
  List<Car> get cars => _cars;
  List<Booking> get bookings => _bookings;
  List<Invoice> get invoices => _invoices;
  List<Admin> get admins => _admins;

  void start() {
    _cars = ca;
    _admins = ad;
    _customers = cust;
  }

  CarRentalSystem({
    List<Customer>? cust,
    List<Car>? CARS,
    List<Booking>? bookings,
    List<Invoice>? invoices,
    List<Admin>? admins,
    bool isAdmin = false,
  })  : _bookings = bookings ?? [],
        _invoices = invoices ?? [];
  Booking? createBooking({
    required Customer customer,
    required Car car,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
  }) {
    if (!car.available) {
      print("Car not available.");
      return null;
    }

    Booking booking = car.createBooking(
        customer: customer,
        startDate: startDate,
        endDate: endDate,
        lateReturnFees:
            lateReturnFees); // w gwa kol function b2a n implement el logic bta3 el paramters el zyada ely m7tagha

    booking.calculateTotalCost();
    _bookings.add(booking);
    customer.addBooking(booking);
    car.available = false;

    print("Car booked successfully ");

    return booking;
  }

  void returnCar({required Booking booking, required DateTime returnDate}) {
    Invoice inv = booking.createInvoice(returnDate);
    inv.generateInvoice();
    _invoices.add(inv);
    booking.car.available = true;
  }

  void trackReservations() {
    saveInvoicesToExcel(_invoices);
    saveBookingsToExcel(_bookings);
    saveInvoicesToFile(_invoices);
    saveBookingsToFile(_bookings);

    print("Reservation reports generated successfully!");
  }

  bool check(String username, String password) {
    if (admins.any(
        (admin) => admin.username == username && admin.password == password))
      return true;

    return false;
  }

  GenerateReports(String username, String password) {
    {
      if (check(username, password))
        trackReservations();
      else {
        print("Password and/or username not correct");
      }
    }
  }

  void RegisterCustomer(Customer customer) {
    _customers.add(customer);
  }

  void addCar(Car car) {
    _cars.add(car);
  }

  void displayAllInvoices() {
    print("\nAll Invoices:");
    for (var invoice in _invoices) {
      invoice.generateInvoice();
    }
  }

  void displayAllBookings() {
    print("\nAll Bookings:");
    for (var booking in _bookings) {
      booking.displayBookingDetails();
    }
  }
}
