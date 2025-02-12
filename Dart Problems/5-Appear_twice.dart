import 'dart:io';

void main() {
  print("Enter the numbers separated by space:");
  List<int> numbers = stdin
      .readLineSync()!
      .split(' ')
      .map(int.parse)
      .toList(); // 2 xor 2 = 0 , 2 xor 2 xor 1 xor 1 xor 3 xor 3 = 0
  // 0 xor anything = anything
  int ans = 0;
  numbers.forEach((element) {
    ans = ans ^ element;
  });
  print(ans);
}
