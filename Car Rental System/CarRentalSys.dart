import 'package:excel/excel.dart';

import 'Admins/Admin.dart';
import 'Bookings/Booking.dart';
import 'Bookings/ElectricCarBooking.dart';
import 'Bookings/SportsCarBooking.dart';
import 'Cars/Car.dart';
import 'Cars/ElectricCar.dart';
import 'Cars/SportsCar.dart';
import 'Customers/Customer.dart';

import 'Invoices/Invoice.dart';
import 'dart:io';
// lesa me7tag atb2 4wyt solid tany hena brdo ( did somethings )
// problem: I solved the open closed principle , but got a single responsibility issue
// 1- creating a booking in a car
// 2- creating an invoice in a booking

// ana 3mlt invoices fe kza class 34an kol invoice fe3ln by5tlf 3n el tany fe el output bta3o
// fa 34an awry el e5tlaf dh tb3to fe txt file
// w laken brdw 3mlt excel file w 7tyt kolo m3 kolo w el zyada kan feeh 0$ , the reason I created several inherited classes :D

class CarRentalSystem {
  List<Customer> _customers;
  List<Car> _cars;
  List<Booking> _bookings;
  List<Invoice> _invoices;
  List<Admin> _admins;

  List<Customer> get customers => _customers;
  List<Car> get cars => _cars;
  List<Booking> get bookings => _bookings;
  List<Invoice> get invoices => _invoices;
  List<Admin> get admins => _admins;

  CarRentalSystem({
    List<Customer>? customers,
    List<Car>? cars,
    List<Booking>? bookings,
    List<Invoice>? invoices,
    List<Admin>? admins,
    bool isAdmin = false,
  })  : _customers = customers ?? [],
        _cars = cars ?? [],
        _bookings = bookings ?? [],
        _invoices = invoices ?? [],
        _admins = admins ?? [];

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
    _saveInvoicesToExcel();
    _saveBookingsToExcel();
    _saveInvoicesToFile();
    _saveBookingsToFile();

    print("Reservation reports generated successfully!");
  }

  void _saveInvoicesToExcel() {
    var excel = Excel.createExcel();
    var sheet = excel['Invoices'];

    // Adding Headers
    sheet.appendRow([
      'Invoice ID',
      'Booking ID',
      'Customer Name',
      'Car ID',
      'Type',
      'Rent Per Day',
      'Late Return Fees',
      'Start Date',
      'End Date',
      'Return Date',
      'Base Cost',
      'charging Fees',
      'Luxury Fees',
      'Additional Fees',
      'Total Amount'
    ]);

    for (var invoice in _invoices) {
      var car = invoice.booking.car;
      String type = car.runtimeType.toString();
      var booking = invoice.booking;
      sheet.appendRow([
        invoice.id,
        booking.id,
        booking.customer.name,
        car.id,
        type,
        car.rentPriceAday,
        booking.lateReturnFees,
        booking.startDate.toString(),
        booking.endDate.toString(),
        invoice.returnDate.toString(),
        invoice.baseCost,
        if (type == "ElectricCar")
          (booking as ElectricCarBooking).chargeCar
              ? (car as ElectricCar).chargingFees
              : 0
        else
          0,
        if (type == "SportsCar") (car as SportsCar).luxuryFees else 0,
        invoice.additionalFees,
        invoice.totalAmount
      ]);
    }

    File('invoices_report.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
  }

  void _saveBookingsToExcel() {
    var excel = Excel.createExcel();
    var sheet = excel['Bookings'];

    // Adding Headers
    sheet.appendRow([
      'Booking ID',
      'Customer Name',
      'Car ID',
      'Type',
      'Rent Per Day',
      'Charging Fees',
      'Luxury Fees',
      'Start Date',
      'End Date',
      'Total Cost'
    ]);

    for (var booking in _bookings) {
      var car = booking.car;
      String type = car.runtimeType.toString();
      sheet.appendRow([
        booking.id,
        booking.customer.name,
        car.id,
        type,
        car.rentPriceAday,
        if (booking is ElectricCarBooking)
          booking.chargeCar ? (booking.car as ElectricCar).chargingFees : 0
        else
          0,
        if (booking is SportsCarBooking)
          (booking.car as SportsCar).luxuryFees
        else
          0,
        booking.startDate.toString(),
        booking.endDate.toString(),
        booking.totalCost
      ]);
    }

    File('bookings_report.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
  }

  GenerateReports(String username, String password) {
    {
      if (admins.any(
          (admin) => admin.username == username && admin.password == password))
        trackReservations();
      else {
        print("Password and/or username not correct");
      }
    }
  }

  void _saveInvoicesToFile()  {
    try {
      final file = File('invoices_report.txt');
      print("Saving to file: ${file.absolute.path}");

      StringBuffer buffer = StringBuffer();
      buffer.writeln("All Invoices:\n");

      for (var invoice in _invoices) {
        Car car = invoice.booking.car;
        buffer.writeln("Invoice ID: ${invoice.id}");
        buffer.writeln("Booking ID: ${invoice.booking.id}");
        buffer.writeln("Customer: ${invoice.booking.customer.name}");
        buffer.writeln("Car ID: ${car.id}");
        buffer.writeln("Type: ${car.runtimeType}");
        buffer.writeln("Rent Per Day: ${car.rentPriceAday}");
        buffer.writeln(
            "Late Return fees per day: ${invoice.booking.lateReturnFees}");
        buffer.writeln("Start Date: ${invoice.booking.startDate}");
        buffer.writeln("End Date: ${invoice.booking.endDate}");
        buffer.writeln("Return Date: ${invoice.returnDate}");
        buffer.writeln("Base Cost: \$${invoice.baseCost}");

        if (car is ElectricCar && invoice.booking is ElectricCarBooking) {
          buffer.writeln(
              "Charging Fees: \$${(invoice.booking as ElectricCarBooking).chargeCar ? car.chargingFees : 0}");
        } else if (car is SportsCar) {
          buffer.writeln("Luxury Fees: \$${car.luxuryFees}");
        }

        buffer.writeln(
            "Additional Fees (Late days): \$${invoice.additionalFees}");
        buffer.writeln("Total Amount: \$${invoice.totalAmount}");
        buffer.writeln("-----------------------------------");
      }

      file.writeAsStringSync(buffer.toString()); // by5ly el mwdo3 sync , msh b7tag a await aw a3ml exit lel program , la2 , hwa be update 3la tool as we are going , learn it

      print("Invoices saved successfully!");
    } catch (e) {
      print("Error saving invoices to file: $e");
    }
  }

  void _saveBookingsToFile() {
    final file = File('bookings_report.txt');

    StringBuffer buffer = StringBuffer();
    buffer.writeln("All Bookings:\n");

    for (var booking in _bookings) {
      Car car = booking.car;
      buffer.writeln("Booking ID: ${booking.id}");
      buffer.writeln("Customer: ${booking.customer.name}");
      buffer.writeln("Car ID: ${car.id}");
      String type = booking.car.runtimeType.toString();
      buffer.writeln("Type: $type");
      buffer.writeln("Rent Per Day: ${car.rentPriceAday}");

      if (type == "ElectricCar") {
        buffer.writeln(
            "Charging Fees: \$${(booking as ElectricCarBooking).chargeCar ? (car as ElectricCar).chargingFees : 0}");
      } else if (type == "SportsCar") {
        buffer.writeln("Luxury Fees: \$${(car as SportsCar).luxuryFees}");
      }

      buffer.writeln("Start Date: ${booking.startDate}");
      buffer.writeln("End Date: ${booking.endDate}");
      buffer.writeln("Total Cost if returned on time: \$${booking.totalCost}");
      buffer.writeln("-----------------------------------");
    }

    file.writeAsStringSync(buffer.toString()); // by5ly el mwdo3 sync , msh b7tag a await aw a3ml exit lel program , la2 , hwa be update 3la tool as we are going , learn it
    print("Bookings saved successfully!");
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
