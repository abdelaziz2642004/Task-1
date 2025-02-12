import 'dart:io';

void main() {
  print("Enter the numbers separated by space:");
  List<int> list = stdin.readLineSync()!.split(' ').map(int.parse).toList();
  int maxx = list[0];
  int minn = maxx;

  list.forEach((element) {
    if (maxx < element) maxx = element;
    if (minn > element) minn = element;
  });

  // print("max: $maxx, min: $minn");
  print("Sum: ${minn + maxx}");

  // another way
  print(
      "max: ${list.reduce((curr, next) => curr > next ? curr : next)}"); // 8 --> Max
  print("min: ${list.reduce((curr, next) => curr < next ? curr : next)}");
}
