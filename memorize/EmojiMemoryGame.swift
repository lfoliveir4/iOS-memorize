//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Luis Filipe Alves de Oliveira on 17/04/21.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numbersOfPairsOfCards: emojis.count) { pairIndex in return emojis[pairIndex] }
    }
        
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func chooseCard(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.chooseCards(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
