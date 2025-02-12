import 'dart:io';

import 'CarRentalSys.dart';
import 'Cars/Car.dart';
import 'Customers/Customer.dart';
import 'DummyData/dummy.dart';

void main()  {


  // // final file = File('bookings_report.txt');
  // // var sink = file.openWrite();
  // // sink.writeln("All Bookings:\n");
  // // sink.close();
  CarRentalSystem sys = CarRentalSystem(
      bookings: [],
      cars: cars,
      customers: customers,
      invoices: [],
      admins: admins);

  // while(true){
  //   print("hello");
  //   break;
  // }

  while (true) {
    print("\nCar Rental System");
    print("1. Customer");
    print("2. Admin");
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

void registerCustomer(CarRentalSystem sys) {
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter your Email: ");
  String email = stdin.readLineSync()!;

  // lw mwgod abl kda
  while (sys.customers.any((customer) => customer.email == email)) {
    print("Email already registered. Please use a different email.");
    stdout.write("Enter your Email: ");
    email = stdin.readLineSync()!;
  }
  stdout.write("Enter your password: ");
  String password = stdin.readLineSync()!;

  // Create a new Customer object
  Customer newCustomer = Customer(
    name: name,
    email: email,
    password: password,
    phone: "010000000",
    address: "@@",
  );

  sys.RegisterCustomer(newCustomer);
  print("Customer registered successfully!");
  handleCustomerActions(sys, newCustomer);
}

void handleCustomer(CarRentalSystem sys) {
  print("1. New Customer");
  print("2. Existing Customer");
  stdout.write("Choose an option: ");

  String? input = stdin.readLineSync();
  int? customerChoice = int.tryParse(input ?? "");

  if (customerChoice == 1) {
    registerCustomer(sys);
  } else if (customerChoice == 2) {
    print("---------");
    print('\n Try "ahmed@example.com", "123456"');

    stdout.write("Enter your Email: ");
    String? email = stdin.readLineSync();
    stdout.write("Enter your password: ");
    String? password = stdin.readLineSync();

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      print("Invalid email or password.");
      return;
    }
    Customer? cus;
    for (var customer in sys.customers) {
      if (customer.email == email && customer.password == password) {
        cus = customer;
        break;
      }
    }
    if (cus != null) {
      handleCustomerActions(sys, cus);
    } else {
      print("Invalid email or password.");
    }
  } else {
    print("Invalid choice.");
  }
}

void handleCustomerActions(CarRentalSystem sys, Customer customer) {
  while (true) {
    print("1. Book a car");
    print("2. Return a car");
    print("3. exit");

    stdout.write("Choose an option: ");
    int customerAction = int.parse(stdin.readLineSync()!);

    if (customerAction == 1) {
      bookCar(sys, customer);
    } else if (customerAction == 2) {
      returnCar(sys, customer);
    } else if (customerAction == 3) {
      return;
    }
  }
}

void returnCar(CarRentalSystem sys, Customer cus) {
  if (cus.OngoingBookings.isEmpty) {
    print("You have no ongoing bookings.");
    return;
  } else {
    print("Select a booking to return:");
    for (int i = 0; i < cus.OngoingBookings.length; i++) {
      print("( ${i + 1}* )");
      cus.OngoingBookings[i].displayBookingDetails();
    }
    int index = getIntInput("Select a booking (Enter index): ") - 1;
    while (index < 0 || index >= cus.OngoingBookings.length) {
      print("Invalid choice. Enter a valid index");
      index = getIntInput("Select a booking (Enter index): ") - 1;
    }
    DateTime returnDate = getDateInput("Enter the return date (yyyy-mm-dd): ");
    sys.returnCar(booking: cus.OngoingBookings[index], returnDate: returnDate);
    cus.removeBooking(cus.OngoingBookings[index]);
  }
}

void handleAdmin(CarRentalSystem sys) async {
  print('try: "admin","admin"');
  stdout.write("Enter Username: ");
  String username = stdin.readLineSync()!;
  stdout.write("Enter admin password: ");
  String password = stdin.readLineSync()!;
  sys.GenerateReports(username, password);
}

void bookCar(CarRentalSystem sys, Customer customer) {
  List<Car> cars = sys.cars;
  print("Pick an avilable car from these cars:");

  for (int i = 0; i < cars.length; i++) {
    print(
        "${i + 1}. ${cars[i].year} - \$${cars[i].rentPriceAday}/day - ${cars[i].runtimeType} ( ${cars[i].available ? "available" : "NOT available"} )");
  }
  int index = getIntInput("Select a car (Enter index): ") - 1;
  while (index < 0 || index >= cars.length || !cars[index].available) {
    print("Invalid choice. try another index");
    index = getIntInput("Select a car (Enter index): ") - 1;
  }

  DateTime startDate = getDateInput("Enter the start date (yyyy-mm-dd): ");
  DateTime endDate = getDateInput("Enter the end date (yyyy-mm-dd): ");
  Car selectedCar = cars[index];

  double lateReturnFees = selectedCar.rentPriceAday * 2; // msln

  sys.createBooking(
      customer: customer,
      car: selectedCar,
      startDate: startDate,
      endDate: endDate,
      lateReturnFees: lateReturnFees);

  // better --> sys.createBooking();
  // bs el fekra fe el parameters el mo5tlfa ! what to do with that
  // omg I can get the input from within ?! :DDDD
}

int getIntInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    try {
      return int.parse(input!);
    } catch (e) {
      print("Invalid input. Please enter a valid number.");
    }
  }
}

DateTime getDateInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    try {
      return DateTime.parse(input!);
    } catch (e) {
      print(
          "Invalid date format. Please enter a date in the format yyyy-mm-dd.");
    }
  }
}

bool getYesNoInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? choice = stdin.readLineSync()?.toLowerCase();
    if (choice == "y" || choice == "n") {
      return choice == "y";
    }
    print("Invalid choice. Enter 'Y' or 'N'.");
  }
}
