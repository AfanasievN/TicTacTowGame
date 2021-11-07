//
//  ContentView.swift
//  TicTacTow
//
//  Created by Nichita Afanasiev on 07.11.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .bold()
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
            
        }
        .foregroundColor(Color.yellow)
        .alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Game Over"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "You Win!": "AI Wins!" : "Nobody Wins") ,
                  dismissButton: Alert.Button.destructive(
                        Text("Ok"),
                        action: {self.ticTacToeModel.resetGame()}
             ))
        })
    }
    
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
}
