import 'dart:io';

void main() {
  String s = stdin.readLineSync()!;
  List<String> list = s.split(' ');
  print(list[list.length - 1].length);
}
