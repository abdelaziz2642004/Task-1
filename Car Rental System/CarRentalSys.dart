import 'Bookings/Booking.dart';
import 'Bookings/EconomyCarBooking.dart';
import 'Bookings/ElectricCarBooking.dart';
import 'Bookings/SportsCarBooking.dart';
import 'Cars/Car.dart';
import 'Cars/ElectricCar.dart';
import 'Cars/SportsCar.dart';
import 'Customers/Customer.dart';

import 'Invoices/Invoice.dart';
import 'dart:io';

// lesa me7tag atb2 4wyt solid tany hena brdo

class CarRentalSystem {
  List<Customer> customers = [];
  List<Car> cars = [];
  List<Booking> bookings = [];
  List<Invoice> invoices = [];
  bool _isAdmin = false;
  CarRentalSystem(this._isAdmin);

  void setAdminAccess(bool access) {
    _isAdmin = access;
  }

  GenerateReports() {
    if (_isAdmin) {
      trackReservations();
    } else {
      print("You don't have access to this feature.");
    }
  }

  void trackReservations() {
    _saveInvoicesToFile();
    _saveBookingsToFile();
    print("Reservation reports generated successfully!");
  }

  void _saveInvoicesToFile() {
    final file = File('invoices_report.txt');
    var sink = file.openWrite();

    sink.writeln("All Invoices:\n");
    for (var invoice in invoices) {
      Car car = invoice.booking.car;
      sink.writeln("Invoice ID: ${invoice.id}");
      sink.writeln("Booking ID: ${invoice.booking.id}");
      sink.writeln("Customer: ${invoice.booking.customer.name}");
      sink.writeln("Car ID: ${car.id}");
      String type = car.runtimeType.toString();
      sink.writeln("Type: $type");
      sink.writeln("Rent Per Day: ${car.rentPriceAday}");

      sink.writeln(
          "Late Return fees per day: ${invoice.booking.lateReturnFees}");

      sink.writeln("Start Date: ${invoice.booking.startDate}");
      sink.writeln("End Date: ${invoice.booking.endDate}");
      sink.writeln("Return Date: ${invoice.returnDate}");
      sink.writeln("Base Cost: \$${invoice.baseCost}");
      if (type == "ElectricCar") {
        sink.writeln(
            "Charging Fees: \$${(invoice.booking as ElectricCarBooking).chargeCar ? (car as ElectricCar).chargingFees : 0}}");
      } else if (type == "SportsCar") {
        sink.writeln("luxury Fees: \$${(car as SportsCar).luxuryFees}");
      }
      sink.writeln("Additional Fees(Late days): \$${invoice.additionalFees}");
      sink.writeln("Total Amount: \$${invoice.totalAmount}");
      sink.writeln("-----------------------------------");
    }
    sink.close();
  }

  void _saveBookingsToFile() {
    final file = File('bookings_report.txt');
    var sink = file.openWrite();

    sink.writeln("All Bookings:\n");
    for (var booking in bookings) {
      Car car = booking.car;
      sink.writeln("Booking ID: ${booking.id}");
      sink.writeln("Customer: ${booking.customer.name}");
      sink.writeln("Car ID: ${car.id}");
      String type = booking.car.runtimeType.toString();
      sink.writeln("Type: $type");
      sink.writeln("Rent Per Day: ${car.rentPriceAday}");
      sink.writeln("Late Return fees per day: ${booking.lateReturnFees}");

      if (type == "ElectricCar") {
        sink.writeln(
            "Charging Fees: \$${(booking as ElectricCarBooking).chargeCar ? (car as ElectricCar).chargingFees : 0}");
      } else if (type == "SportsCar") {
        sink.writeln("luxury Fees: \$${(car as SportsCar).luxuryFees}");
      }

      sink.writeln("Start Date: ${booking.startDate}");
      sink.writeln("End Date: ${booking.endDate}");
      sink.writeln("Total Cost if returned on time: \$${booking.totalCost}");

      sink.writeln("-----------------------------------");
    }
    sink.close();
  }

  void RegisterCustomer(Customer customer) {
    customers.add(customer);
  }

  void addCar(Car car) {
    cars.add(car);
  }

  Booking? createEconomyCarBooking({
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

    Booking booking = EconomyCarBooking(
      customer: customer,
      car: car,
      startDate: startDate,
      endDate: endDate,
      lateReturnFees: lateReturnFees, // Initial late fee is 0
    );
    booking.calculateTotalCost();
    bookings.add(booking);
    customer.addBooking(booking);
    car.available = false;

    return booking;
  }

  Booking? createElectricBooking({
    required Customer customer,
    required Car car,
    required DateTime startDate,
    required DateTime endDate,
    required double lateReturnFees,
    required bool chargeCar,
  }) {
    if (!car.available) {
      print("Car not available.");
      return null;
    }

    Booking booking = ElectricCarBooking(
        customer: customer,
        car: car,
        startDate: startDate,
        endDate: endDate,
        lateReturnFees: lateReturnFees, // Initial late fee is 0
        chargeCar: chargeCar);
    booking.calculateTotalCost();
    bookings.add(booking);
    customer.addBooking(booking);
    car.available = false;
    return booking;
  }

  Booking? createSportsCarBooking({
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

    Booking booking = SportsCarBooking(
      customer: customer,
      car: car,
      startDate: startDate,
      endDate: endDate,
      lateReturnFees: lateReturnFees, // Initial late fee is 0
    );
    booking.calculateTotalCost();
    bookings.add(booking);
    customer.addBooking(booking);
    car.available = false;

    return booking;
  }

  void returnCar({required Booking booking, required DateTime returnDate}) {
    Invoice inv = booking.createInvoice(returnDate);
    inv.generateInvoice();
    invoices.add(inv);
    booking.car.available = true;
  }

  void displayAllInvoices() {
    print("\nAll Invoices:");
    for (var invoice in invoices) {
      invoice.generateInvoice();
    }
  }

  void displayAllBookings() {
    print("\nAll Bookings:");
    for (var booking in bookings) {
      booking.displayBookingDetails();
    }
  }
}
