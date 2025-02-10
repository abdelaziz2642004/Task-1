import 'dart:io';

void main() {
  // enter size then the elements
  int size = int.parse(stdin.readLineSync()!);
  List<int> nums = [];
  // 2 xor 2 = 0 , 2 xor 2 xor 1 xor 1 xor 3 xor 3 = 0
  // 0 xor anything = anything
  int ans = 0;
  // note : not like c++ , lazm td5l element element aw t8yr el code dh eno y2ra line kaml w split w kda
  for (int i=0;i<size;i++) {nums.add(int.parse(stdin.readLineSync()!));ans^=nums[i];}
  print(ans);
}