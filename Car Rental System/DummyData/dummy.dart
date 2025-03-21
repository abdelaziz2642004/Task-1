import 'dart:io';

import '../Admin/Admin.dart';
import '../Cars/Car.dart';
import '../Cars/EconomyCar.dart';
import '../Cars/ElectricCar.dart';
import '../Cars/SportsCar.dart';
import '../Customer/Customer.dart';

mixin dummy {
  List<Customer> cust = readCustomersFromFile('DummyData/customers.txt');
  List<Admin> ad = readAdminsFromFile('DummyData/admins.txt');
  List<Car> ca = readCarsFromFile('DummyData/cars.txt');
}

List<Customer> readCustomersFromFile(String filePath) {
  print(Directory.current);
  final lines = File(filePath).readAsLinesSync();
  lines.removeAt(0);
  return lines.map((line) {
    var parts = line.split(',');
    return Customer(
      name: parts[0].trim(),
      email: parts[1].trim(),
      phone: parts[2].trim(),
      address: parts[3].trim(),
      password: parts[4].trim(),
    );
  }).toList();
}

List<Admin> readAdminsFromFile(String filePath) {
  final lines = File(filePath).readAsLinesSync();
  lines.removeAt(0);

  return lines.map((line) {
    var parts = line.split(',');
    return Admin(UserName: parts[0].trim(), Password: parts[1].trim());
  }).toList();
}

List<Car> readCarsFromFile(String filePath) {
  final lines = File(filePath).readAsLinesSync();
  lines.removeAt(0);

  return lines.map((line) {
    var parts = line.split(',');
    var type = parts[0].trim();
    var year = int.parse(parts[1].trim());
    var rentPrice = double.parse(parts[2].trim());
    var available = parts[3].trim().toLowerCase() == 'true';

    switch (type) {
      case 'EconomyCar':
        return EconomyCar(
            year: year, rentPriceAday: rentPrice, available: available);
      case 'ElectricCar':
        var fees = double.parse(parts[5].trim());
        return ElectricCar(
          year: year,
          rentPriceAday: rentPrice,
          available: available,
          chargeCapacity: 100,
          chargingFees: fees,
        );
      case 'SportsCar':
        var luxuryFees = double.parse(parts[4].trim());
        return SportsCar(
          year: year,
          rentPriceAday: rentPrice,
          available: available,
          luxuryFees: luxuryFees,
        );
      default:
        throw Exception('Unknown car type: $type');
    }
  }).toList();
}


// import '../Admin/Admin.dart';
// import '../Cars/Car.dart';
// import '../Cars/EconomyCar.dart';
// import '../Cars/ElectricCar.dart';
// import '../Cars/SportsCar.dart';
// import '../Customer/Customer.dart';
//
// List<Customer> customers = [
//   Customer(
//       name: "Ahmed",
//       email: "ahmed@example.com",
//       phone: "123456789",
//       address: "Cairo",
//       password: "123456"),
//   Customer(
//       name: "Sara",
//       email: "sara@example.com",
//       phone: "987654321",
//       address: "Alexandria",
//       password: "123456"),
//   Customer(
//       name: "Omar",
//       email: "omar@example.com",
//       phone: "555444333",
//       address: "Giza",
//       password: "123456"),
//   Customer(
//       name: "Hassan",
//       email: "hassan@example.com",
//       phone: "111222333",
//       address: "Mansoura",
//       password: "123456"),
//   Customer(
//       name: "Lina",
//       email: "lina@example.com",
//       phone: "999888777",
//       address: "Luxor",
//       password: "123456"),
//   Customer(
//       name: "Mina",
//       email: "mina@example.com",
//       phone: "666777888",
//       address: "Aswan",
//       password: "123456"),
// ];
// // map
// List<Admin> admins = [
//   Admin(UserName: "admin", Password: "admin"),
//   Admin(UserName: "admin2", Password: "admin2")
// ];
//
// // 1- book a car
// // 2- Admin Access --> GenerateRe port
//
// List<Car> cars = [
//   EconomyCar(year: 2022, rentPriceAday: 50.7, available: true),
//   EconomyCar(year: 2021, rentPriceAday: 45.0, available: true),
//   ElectricCar(
//     year: 2023,
//     rentPriceAday: 100.5,
//     available: true,
//     chargeCapacity: 400,
//     chargingFees: 20,
//   ),
//   ElectricCar(
//     year: 2022,
//     rentPriceAday: 90.0,
//     available: true,
//     chargeCapacity: 350,
//     chargingFees: 15,
//   ),
//   SportsCar(
//       year: 2021, rentPriceAday: 200.0, available: true, luxuryFees: 50.0),
//   SportsCar(
//       year: 2020, rentPriceAday: 180.0, available: true, luxuryFees: 40.0),
// ];
//
// // // Register Customers in the System
// // for (var customer in customers) {
// //   system.RegisterCustomer(customer);
// // }
//
// // // Add Cars to the System
// // for (var car in cars) {
// //   system.addCar(car);
// // }
//
// // Create Bookings
// // 2 w 3 are electric , let's make one with used charging fees and the other one without
// // List<Booking?> bookings = [
// //   system.createEconomyCarBooking(
// //       customer: customers[0],
// //       car: cars[0],
// //       startDate: DateTime(2024, 2, 1),
// //       endDate: DateTime(2024, 2, 3),
// //       lateReturnFees: 50.7),
// //   // SARA will charge her car :D
// //   system.createElectricBooking(
// //       customer: customers[1],
// //       car: cars[2],
// //       startDate: DateTime(2024, 3, 5),
// //       endDate: DateTime(2024, 3, 10),
// //       lateReturnFees: 100.5,
// //       chargeCar: true),
// //   system.createSportsCarBooking(
// //       customer: customers[2],
// //       car: cars[4],
// //       startDate: DateTime(2024, 4, 12),
// //       endDate: DateTime(2024, 4, 15),
// //       lateReturnFees: 200.0),
// //   system.createEconomyCarBooking(
// //       customer: customers[3],
// //       car: cars[1],
// //       startDate: DateTime(2024, 5, 7),
// //       endDate: DateTime(2024, 5, 9),
// //       lateReturnFees: 45.0),
// //   // lina will not charge her car :D
// //   system.createElectricBooking(
// //       customer: customers[4],
// //       car: cars[3],
// //       startDate: DateTime(2024, 6, 14),
// //       endDate: DateTime(2024, 6, 18),
// //       lateReturnFees: 90.0,
// //       chargeCar: false),
// //   system.createSportsCarBooking(
// //       customer: customers[5],
// //       car: cars[5],
// //       startDate: DateTime(2024, 7, 20),
// //       endDate: DateTime(2024, 7, 25),
// //       lateReturnFees: 180.0),
// // ];
//
// // List<DateTime> time = [
// //   DateTime(2024, 2, 5),
// //   DateTime(2024, 3, 12),
// //   DateTime(2024, 4, 18),
// //   DateTime(2024, 5, 10),
// //   DateTime(2024, 6, 20),
// //   DateTime(2024, 7, 27)
// // ];
// // Return Cars
// // for (int i = 0; i < 6; i++) {
// //   if (bookings[i] != null) {
// //     system.returnCar(booking: bookings[i]!, returnDate: time[i]);
// //   }
// // }
// // }
