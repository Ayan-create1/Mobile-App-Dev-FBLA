List<List<String>> placeHorizontal(
    int row, int column, String word, List<List<String>> board) {
  List<List<String>> fBoard = board;
  for (int i = 0; i < word.length; i++) {
    fBoard[row][column + i] = word[i];
  }
  return fBoard;
}

List<List<String>> placeVertical(
    int row, int column, String word, List<List<String>> board) {
  List<List<String>> fBoard = board;
  for (int i = 0; i < word.length; i++) {
    fBoard[row + i][column] = word[i];
  }
  return fBoard;
}
