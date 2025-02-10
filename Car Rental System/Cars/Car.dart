import 'package:uuid/uuid.dart';

abstract class Car {
  String _id;
  int _year; // model ?
  double rentPriceAday;
  bool available;

  Car(this._year, this.rentPriceAday, this.available) : _id = Uuid().v4();

  set setAvailable(bool available) {
    this.available = available;
  }

  set setRentPriceAday(double price) {
    this.rentPriceAday = price;
  }

  void displayCarDetails() {
    print("Car ID: $_id");
    print("Year: $_year");
    print("Rent Price: $rentPriceAday");
    print("Available: $available");
  }

  double calcCost(double days) {
    return days * rentPriceAday;
  }

  String get id => _id;
  int get year => _year;
}
