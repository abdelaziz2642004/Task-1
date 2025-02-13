import 'dart:io';
import 'CarRentalSys.dart';
import 'MenuCode/MenuFunctions.dart';

// NOTE: if u run this on intellij it will run fine
// but if u run this on vs code , after u get an error
//enter this command: cd Car Rental System
// then re run
// OR , in vs code , open folder "Car Rental System" as a project on its own and it will run fine
// I tried changing alot of settings but no help , will check this later

void main() {
  CarRentalSystem sys = CarRentalSystem();
  sys.start(); // 34an el initialization lel customers,admins,cars 34an ana 3mlthm late final

  while (true) {
    print("\nCar Rental System");
    print("1. Customer");
    print("2. Admin (Reports Generation)");
    print("3. Exit");
    stdout.write("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        handleCustomer(sys);
        break;
      case 2:
        handleAdmin(sys);
        break;
      case 3:
        print("Exiting...");
        return;
      default:
        print("Invalid choice. Try again.");
    }
  }
}
