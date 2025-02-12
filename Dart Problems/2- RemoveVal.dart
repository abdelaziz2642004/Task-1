// void removeValues(List<int> res, int val,int index,List<int> numbers) {
//   if (index==numbers.length()) return; 
//   if (numbers[index] != val) {
//     res.add(numbers[index]);
//   }
//   removeValues(res, val, index+1,numbers);
 
// }
// List<int> removeValuesHelper(List<int> numbers,int val){
//   List<int> res=[];
//   removeValues(res,val,0,numbers);
//   return res;
// }

import 'dart:io';


void main() {
  // recursive ?
  // built in I guess

    // int val = 2;
  // List<int> result = removeValues(numbers, val);
  // print(result); // Output:
 print("Enter the numbers separated by space:");
  List<int> numbers = stdin.readLineSync()!
      .split(' ') 
      .map(int.parse) 
      .toList();

  int val = 2;
  numbers.removeWhere((element) => element == val);

  print(numbers);

}
