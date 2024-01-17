import { LightningElement, track } from 'lwc';
const X_SYMBOL = 'X';
const O_SYMBOL = 'O';
const EMPTY_SYMBOL = '';
export default class ForTeating extends LightningElement {
   gameBoard = [];
   currentPlayer = X_SYMBOL;
   gameIsOver = false;
   winner = null;

   connectedCallback() {
      this.resetGame();
   }

   resetGame() {
      this.gameBoard = Array.from({ length: 3 }, () => Array.from({ length: 3 }, () => ({ id: Math.random(), symbol: EMPTY_SYMBOL, status: 'cell' })));
      this.currentPlayer = X_SYMBOL;
      this.gameIsOver = false;
      this.winner = null;
   }

   handleCellClick(event) {
      const cellId = event.currentTarget.dataset.cellId;
      const rowIndex = Math.floor(cellId / 3);
      const columnIndex = cellId % 3;
      if (!this.gameIsOver && this.gameBoard[rowIndex][columnIndex].symbol === EMPTY_SYMBOL) {
         this.gameBoard[rowIndex][columnIndex].symbol = this.currentPlayer;
         this.gameBoard[rowIndex][columnIndex].status = `cell ${this.currentPlayer}`;
         this.checkForWinner();
         this.currentPlayer = this.currentPlayer === X_SYMBOL ? O_SYMBOL : X_SYMBOL;
      }
   }

   checkForWinner() {
      // check rows
      for (let i = 0; i < this.gameBoard.length; i++) {
         if (this.gameBoard[i][0].symbol === this.gameBoard[i][1].symbol && this.gameBoard[i][1].symbol === this.gameBoard[i][2].symbol && this.gameBoard[i][0].symbol !== EMPTY_SYMBOL) {
            this.gameIsOver = true;
            this.winner = this.gameBoard[i][0].symbol;
         }
      }
      // check diagonals
      if (this.gameBoard[0][0].symbol === this.gameBoard[1][1].symbol && this.gameBoard[1][1].symbol === this.gameBoard[2][2].symbol && this.gameBoard[0][0].symbol !== EMPTY_SYMBOL) {
         this.gameIsOver = true;
         this.winner = this.gameBoard[0][0].symbol;
      }
      if (this.gameBoard[0][2].symbol === this.gameBoard[1][1].symbol && this.gameBoard[1][1].symbol === this.gameBoard[2][0].symbol && this.gameBoard[0][2].symbol !== EMPTY_SYMBOL) {
         this.gameIsOver = true;
         this.winner = this.gameBoard[0][2].symbol;
      }
   }

   handleReset() {
      this.resetGame();
   }
}