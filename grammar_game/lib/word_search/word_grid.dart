import 'check_methods.dart';
import 'placement_methods.dart';
import 'dart:math';

List<List<String>> test() {
  Random random = Random();
//int randomInt = random.nextInt(101); 0 10 100
//print ('random number: $randomInt');
//matrix[vertical][horizontal]]

  List<String> randKeys = [];

  Map<String, String> words = {
    'run': "present",
    'fought': "past",
    'saw': "present",
    'will_go': "future",
    'will_see': "future",
    'drank': "past",
    'could_work': "conditional",
  };

  List<String> keys = words.keys.toList();
  for (int i = 0; i < 4; i++) {
    int num = random.nextInt(keys.length);
    randKeys.add(keys[num]);
    keys.remove(keys[num]);
  }

  List<List<String>> matrix = [
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"]
  ];

  for (int i = 0; i < randKeys.length; i++) {
    bool placed = false;
    String word = randKeys[i];
    while (placed == false) {
      int direction = random.nextInt(2);
      if (direction == 0) {
        int startRow = random.nextInt(10);
        int startColumn = random.nextInt(10 - word.length + 1);
        placed = checkHorizontalPlacement(startRow, startColumn, word, matrix);
        if (placed == true) {
          matrix = placeHorizontal(startRow, startColumn, word, matrix);
          break;
        } else {
          continue;
        }
      } else if (direction == 1) {
        int startRow = random.nextInt(10 - word.length + 1);
        int startColumn = random.nextInt(10);
        placed = checkVerticalPlacement(startRow, startColumn, word, matrix);
        if (placed == true) {
          matrix = placeVertical(startRow, startColumn, word, matrix);
          break;
        } else {
          continue;
        }
      }
    }
  }
  return matrix;
}
