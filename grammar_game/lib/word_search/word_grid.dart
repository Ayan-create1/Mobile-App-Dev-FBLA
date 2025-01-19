import 'check_methods.dart';
import 'placement_methods.dart';
import 'dart:math';

List<List<String>> getWords() {
  Random random = Random();
//int randomInt = random.nextInt(101); 0 10 100
//print ('random number: $randomInt');
//matrix[vertical][horizontal]]

  List<String> randKeys = [];
  List<String> randVals = [];

  Map<String, String> words = {
    'run': "present",
    'fought': "past",
    'saw': "present",
    'will-go': "future",
    'will-see': "future",
    'drank': "past",
    'could-work': "conditional",
    'want': "present",
    'ate': "past",
    'watched': "past",
    'write': "present",
    'draw': "present",
  };

  List<String> keys = words.keys.toList();
  List<String> vals = words.values.toList();

  for (int i = 0; i < 10; i++) {
    int num = random.nextInt(keys.length);
    randKeys.add(keys[num]);
    randVals.add(vals[num]);
    keys.remove(keys[num]);
    vals.remove(vals[num]);
  }

  return [randKeys, randVals];
}

List<List<String>> test(List<String> randKeys) {
  Random random = Random();

  List<String> letterList = [
    '-',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];

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

  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      if (matrix[i][j] == "_") {
        int index = random.nextInt(27);
        matrix[i][j] = letterList[index];
      }
    }
  }
  return matrix;
}
