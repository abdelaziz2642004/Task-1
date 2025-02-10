import 'dart:io';


void main() {
  int size = int.parse(stdin.readLineSync()!);
  List<int> numbers = [];
  int x = int.parse(stdin.readLineSync()!);
  numbers.add(x);

  int maxx =numbers[0];
  int minn =numbers[0];
  for (int i=1;i<size;i++) {
    x = int.parse(stdin.readLineSync()!);
    if (x > maxx) {
      maxx = x;
    }
    if (x < minn) {
      minn = x;
    }
  }

  int sum = maxx + minn;
  print(sum);
}
