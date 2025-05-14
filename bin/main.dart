
import 'dart:io';
import 'dart:math';

void main() {
  print('Welcome to Tic-Tac-Toe - Play against the computer\n');

  while (true) {
    List<String> board = List.generate(9, (index) => (index + 1).toString());
    bool gameOver = false;
    int moveCount = 0;

    print('You are X, the computer is O');

    while (!gameOver) {
      printBoard(board);

      // Player move
      int playerMove = getPlayerMove('X', board);
      board[playerMove - 1] = 'X';
      moveCount++;

      if (checkWin(board, 'X')) {
        printBoard(board);
        print(' Congratulations! You win!');
        gameOver = true;
        break;
      }

      if (moveCount == 9) {
        printBoard(board);
        print(' Its a draw!');
        break;
      }

      // Computer move
      print('Computers turn...');
      sleep(Duration(seconds: 1));
      int aiMove = getComputerMove(board);
      board[aiMove] = 'O';
      moveCount++;

      if (checkWin(board, 'O')) {
        printBoard(board);
        print('💻 The computer wins!');
        gameOver = true;
        break;
      }

      if (moveCount == 9) {
        printBoard(board);
        print('Its a draw!');
        break;
      }
    }

    if (!playAgain()) {
      print('Thanks for playing!');
      break;
    }
  }
}

void printBoard(List<String> board) {
  print('\nCurrent board state:');
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('-----------');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('-----------');
  print(' ${board[6]} | ${board[7]} | ${board[8]} \n');
}

int getPlayerMove(String player, List<String> board) {
  while (true) {
    stdout.write('Enter a cell number (1-9): ');
    String? input = stdin.readLineSync();

    if (input == null || int.tryParse(input) == null) {
      print('Please enter a valid number between 1 and 9.');
      continue;
    }

    int move = int.parse(input);
    if (move < 1 || move > 9) {
      print('Number is out of range.');
    } else if (board[move - 1] == 'X' || board[move - 1] == 'O') {
      print('That cell is already taken. Try again.');
    } else {
      return move;
    }
  }
}

int getComputerMove(List<String> board) {
  List<int> emptyIndices = [];
  for (int i = 0; i < board.length; i++) {
    if (board[i] != 'X' && board[i] != 'O') {
      emptyIndices.add(i);
    }
  }
  return emptyIndices[Random().nextInt(emptyIndices.length)];
}

bool checkWin(List<String> board, String player) {
  List<List<int>> winningCombos = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6]             // Diagonals
  ];

  return winningCombos.any((combo) =>
      combo.every((index) => board[index] == player));
}

bool playAgain() {
  while (true) {
    stdout.write('Do you want to play again? (y/n): ');
    String? input = stdin.readLineSync()?.toLowerCase();

    if (input == 'y') return true;
    if (input == 'n') return false;
    print('Please enter "y" or "n".');
  }
}
