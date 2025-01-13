import 'dart:math';

void test() {
  Random random = Random();

//int randomInt = random.nextInt(101); 0 10 100
//print ('random number: $randomInt');
//matrix[vertical][horizontal]]

  List<String> randKeys = [];

  Map<String, String> words = {
    'run': "present",
    'fought': "past",
    'saw': "present",
    'will go': "future",
    'will see': "future",
  };

  int randomInt = random.nextInt(2);
  List<String> keys = words.keys.toList();
  for (int i = 0; i < 3; i++) {
    int num = random.nextInt(keys.length);
    randKeys.add(keys[num]);
    randKeys.remove(keys[num]);
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
}
