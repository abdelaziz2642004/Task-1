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

  print("max: $maxx, min: $minn");
}
