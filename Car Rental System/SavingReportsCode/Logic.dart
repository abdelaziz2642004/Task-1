import 'dart:io';

import 'package:excel/excel.dart';

import '../Bookings/Booking.dart';
import '../Bookings/ElectricCarBooking.dart';
import '../Bookings/SportsCarBooking.dart';
import '../Cars/Car.dart';
import '../Cars/ElectricCar.dart';
import '../Cars/SportsCar.dart';
import '../Invoices/Invoice.dart';

mixin ReportLogic {

  void saveInvoicesToExcel(List<Invoice> list) {
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

    for (var invoice in list) {
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
        if (type == "SportsCar") (car as SportsCar).luxuryFees else
          0,
        invoice.additionalFees,
        invoice.totalAmount
      ]);
    }

    File('Reports/invoices_report.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
  }

  //---------------------

  void saveBookingsToExcel(List<Booking> list) {
    var excel = Excel.createExcel();
    var sheet = excel['Bookings'];

    // Adding Headers
    sheet.appendRow([
      'Booking ID',
      'Customer Name',
      'Car ID',
      'Type',
      'Rent Per Day',
      'late return fees/day',
      'Charging Fees',
      'Luxury Fees',
      'Start Date',
      'End Date',
      'Total Cost'
    ]);

    for (var booking in list) {
      var car = booking.car;
      String type = car.runtimeType.toString();
      sheet.appendRow([
        booking.id,
        booking.customer.name,
        car.id,
        type,
        car.rentPriceAday,
        booking.lateReturnFees,
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

    File('Reports/bookings_report.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
  }

  void saveInvoicesToFile(List<Invoice> list) {
    try {
      final file = File('Reports/invoices_report.txt');
      print("Saving to file: ${file.absolute.path}");

      StringBuffer buffer = StringBuffer();
      buffer.writeln("All Invoices:\n");

      for (var invoice in list) {
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

      file.writeAsStringSync(buffer
          .toString()); // by5ly el mwdo3 sync , msh b7tag a await aw a3ml exit lel program , la2 , hwa be update 3la tool as we are going , learn it

      print("Invoices saved successfully!");
    } catch (e) {
      print("Error saving invoices to file: $e");
    }
  }

  void saveBookingsToFile(List<Booking> list) {
    final file = File('Reports/bookings_report.txt');

    StringBuffer buffer = StringBuffer();
    buffer.writeln("All Bookings:\n");

    for (var booking in list) {
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

    file.writeAsStringSync(buffer
        .toString()); // by5ly el mwdo3 sync , msh b7tag a await aw a3ml exit lel program , la2 , hwa be update 3la tool as we are going , learn it
    print("Bookings saved successfully!");
  }
}