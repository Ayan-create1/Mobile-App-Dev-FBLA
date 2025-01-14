//import 'dart:math';

bool checkHorizontalPlacement(
    int row, int column, String word, List<List<String>> board) {
  bool status = true;
  for (int i = 0; i < word.length; i++) {
    if (board[row][column + i] == ("_") ||
        board[row][column + i] == (word[i])) {
      status = true;
    } else {
      return false;
    }
  }
  return status;
}

bool checkVerticalPlacement(
    int row, int column, String word, List<List<String>> board) {
  bool status = true;
  for (int i = 0; i < word.length; i++) {
    if (board[row+i][column] == ("_") ||
        board[row+i][column] == (word[i])) {
      status = true;
    } else {
      return false;
    }
  }
  return status;
}