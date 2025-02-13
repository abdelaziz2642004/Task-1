import 'dart:io';
import '../CarRentalSys.dart';
import '../Cars/Car.dart';
import '../Customer/Customer.dart';

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
    print('\n Try "${sys.customers[0].email}", "${sys.customers[0].password}"');

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
    print("3. Edit Your Details");
    print("4. exit");

    stdout.write("Choose an option: ");
    int customerAction = int.parse(stdin.readLineSync()!);

    if (customerAction == 1) {
      bookCar(sys, customer);
    } else if (customerAction == 2) {
      returnCar(sys, customer);
    } else if (customerAction == 3) {
      handleCustomerInfo(customer, sys);
    } else if (customerAction == 4) {
      return;
    }
  }
}

void handleCustomerInfo(Customer oldCustomer, CarRentalSystem system) {
  Customer newCustomer = Customer(
    name: oldCustomer.name,
    email: oldCustomer.email,
    phone: oldCustomer.phone,
    address: oldCustomer.address,
    password: oldCustomer.password,
  );

  while (true) {
    print("What do you want to update?");
    print("1. Email");
    print("2. Password");
    print("3. Name");
    print("4. Address");
    print("5. Phone");
    print("6. Exit.");

    stdout.write("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter new email: ");
        newCustomer.email = stdin.readLineSync()!;
        break;
      case 2:
        {
          print("Enter old password to confirm");
          String password = stdin.readLineSync()!;
          if (password == oldCustomer.password) {
            stdout.write("Enter new password: ");
            newCustomer.password = stdin.readLineSync()!;
            break;
          } else {
            print("Password not correct. Try again");
            break;
          }
        }

      case 3:
        stdout.write("Enter new name: ");
        newCustomer.name = stdin.readLineSync()!;
        break;
      case 4:
        stdout.write("Enter new address: ");
        newCustomer.address = stdin.readLineSync()!;
        break;
      case 5:
        stdout.write("Enter new phone: ");
        newCustomer.phone = stdin.readLineSync()!;
        break;
      case 6:
        break;
      default:
        print("Invalid choice.");
    }
    updateCustomerInfoInFile(oldCustomer.email, newCustomer);
    updateCustomerInfoInSystem(oldCustomer.email, newCustomer, system);

    oldCustomer.name = newCustomer.name;
    oldCustomer.email = newCustomer.email;
    oldCustomer.phone = newCustomer.phone;
    oldCustomer.address = newCustomer.address;
    oldCustomer.password = newCustomer.password;
    if (choice == 6) break;
  }
}

void updateCustomerInfoInFile(String oldEmail, Customer newCustomer) {
  final file = File('DummyData/customers.txt');
  final lines = file.readAsLinesSync();
  final updatedLines = lines.map((line) {
    final parts = line.split(',');
    // print(parts[1]);
    if (parts[1].trim() == oldEmail) {
      return '${newCustomer.name}, ${newCustomer.email}, ${newCustomer.phone}, ${newCustomer.address}, ${newCustomer.password}';
    }
    return line;
  }).toList();
  file.writeAsStringSync(updatedLines.join('\n'));
}

void updateCustomerInfoInSystem(
    String oldEmail, Customer newCustomer, CarRentalSystem sys) {
  for (int i = 0; i < sys.customers.length; i++) {
    Customer cus = sys.customers[i];
    if (oldEmail == cus.email) {
      sys.customers[i].email = newCustomer.email;
      sys.customers[i].address = newCustomer.address;
      sys.customers[i].phone = newCustomer.phone;
      sys.customers[i].name = newCustomer.name;
      sys.customers[i].password = newCustomer.password;
      break;
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
  print('try: "${sys.admins[0].username}","${sys.admins[0].password}"');
  stdout.write("Enter Username: ");
  String username = stdin.readLineSync()!;
  stdout.write("Enter admin password: ");
  String password = stdin.readLineSync()!;
  // bool can = sys.check(username, password);

  // kslt a3ml dool bsra7a b2a el mwdo3 b2a avwr meny :(
  // if (can) {
  // while(true){
  //   print("1. Generate Reports(Bookings, Invoices , Customers , Cars)");
  //   print("2. Edit Cars availability");
  //   print("3. Add a car");
  //   print("3. Remove a car");
  //   print("4. Remove a Customer");
  //   print("5. Exit");

  // int choice=int.parse(stdin.readLineSync()!);

  // switch(choice){
  //   case 1:
  //     sys.GenerateReports(username, password);
  //     break;
  //   case 2:
  //     break;
  //   case 3:
  //     break;
  //   case 4:
  //     break;
  //   case 5:
  //     break;
  //   default:
  //     break;
  // }

  //
  // }
  // }
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
