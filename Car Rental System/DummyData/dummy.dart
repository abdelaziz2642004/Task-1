import '../Bookings/Booking.dart';
import '../CarRentalSys.dart';
import '../Cars/Car.dart';
import '../Cars/EconomyCar.dart';
import '../Cars/ElectricCar.dart';
import '../Cars/SportsCar.dart';
import '../Customers/Customer.dart';

class DummyData {
  static void doo(CarRentalSystem system) {
    // List of Customers
    List<Customer> customers = [
      Customer(
          name: "Ahmed",
          email: "ahmed@example.com",
          phone: "123456789",
          address: "Cairo"),
      Customer(
          name: "Sara",
          email: "sara@example.com",
          phone: "987654321",
          address: "Alexandria"),
      Customer(
          name: "Omar",
          email: "omar@example.com",
          phone: "555444333",
          address: "Giza"),
      Customer(
          name: "Hassan",
          email: "hassan@example.com",
          phone: "111222333",
          address: "Mansoura"),
      Customer(
          name: "Lina",
          email: "lina@example.com",
          phone: "999888777",
          address: "Luxor"),
      Customer(
          name: "Mina",
          email: "mina@example.com",
          phone: "666777888",
          address: "Aswan"),
    ];

    // List of Cars
    List<Car> cars = [
      EconomyCar(year: 2022, rentPriceAday: 50.7, available: true),
      EconomyCar(year: 2021, rentPriceAday: 45.0, available: true),
      ElectricCar(
          year: 2023,
          rentPriceAday: 100.5,
          available: true,
          chargeCapacity: 400,
          chargingFees: 20),
      ElectricCar(
          year: 2022,
          rentPriceAday: 90.0,
          available: true,
          chargeCapacity: 350,
          chargingFees: 15),
      SportsCar(
          year: 2021, rentPriceAday: 200.0, available: true, luxuryFees: 50.0),
      SportsCar(
          year: 2020, rentPriceAday: 180.0, available: true, luxuryFees: 40.0),
    ];

    // Register Customers in the System
    for (var customer in customers) {
      system.RegisterCustomer(customer);
    }

    // Add Cars to the System
    for (var car in cars) {
      system.addCar(car);
    }

    // Create Bookings
    List<Booking?> bookings = [
      system.createBooking(customers[0], cars[0], DateTime(2024, 2, 1),
          DateTime(2024, 2, 3), 50.7),
      system.createBooking(customers[1], cars[2], DateTime(2024, 3, 5),
          DateTime(2024, 3, 10), 100.5),
      system.createBooking(customers[2], cars[4], DateTime(2024, 4, 12),
          DateTime(2024, 4, 15), 200.0),
      system.createBooking(customers[3], cars[1], DateTime(2024, 5, 7),
          DateTime(2024, 5, 9), 45.0),
      system.createBooking(customers[4], cars[3], DateTime(2024, 6, 14),
          DateTime(2024, 6, 18), 90.0),
      system.createBooking(customers[5], cars[5], DateTime(2024, 7, 20),
          DateTime(2024, 7, 25), 180.0),
    ];

    // Return Cars
    system.returnCar(bookings[0]!, DateTime(2024, 2, 5));
    system.returnCar(bookings[1]!, DateTime(2024, 3, 12));
    system.returnCar(bookings[2]!, DateTime(2024, 4, 18));
    system.returnCar(bookings[3]!, DateTime(2024, 5, 10));
    system.returnCar(bookings[4]!, DateTime(2024, 6, 20));
    system.returnCar(bookings[5]!, DateTime(2024, 7, 27));
  }
}
