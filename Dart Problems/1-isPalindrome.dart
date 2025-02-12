// bool isPalindrome(int x) {
//   if (x < 0) {
//     return false; // -121 not palin
//   }
//   String s = x.toString();
//   return _isPalindromeHelper(s, 0, s.length - 1);
// }

// bool _isPalindromeHelper(String str, int l, int r) {
//   if (l >= r) {
//     return true; // Base case: all characters checked
//   }
//   if (str[l] != str[r]) {
//     return false; // Characters don't match
//   }
//   return _isPalindromeHelper(str, l + 1, r - 1); // Recursive case
// }

import 'dart:io';

void main() {
  // no loop ?
  // recursively tyb ?
  // built in ?
  // ANSWER ME !
  // I guess built in...
  // print(isPalindrome(454));
  // print(isPalindrome(-66));
  // print(isPalindrome(676));

  // built in ? idk what u mean but okay
  String s = stdin.readLineSync()!;
  String x = s.split('').reversed.join(
      ''); // bfokha le list b3dha reverse el list w then join them in a string
  print(x == s);
}
