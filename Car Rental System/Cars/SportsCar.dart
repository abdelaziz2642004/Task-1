import 'Car.dart';

class SportsCar extends Car {
  double luxuryFees;

  SportsCar({
    required int year,
    required double rentPriceAday,
    required bool available,
    this.luxuryFees = 0,
  }) : super(year, rentPriceAday, available);

  @override
  void displayCarDetails() {
    super.displayCarDetails();
    print("Luxury Fees: $luxuryFees");
  }

  @override
  double calcCost(double days) {
    return super.calcCost(days) + luxuryFees;
  }
}
