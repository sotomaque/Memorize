//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {

    static let emojis = ["✈️", "🚀", "🚗", "🚘", "🚙", "🛫", "🛬", "🏎", "🛵", "🏍", "🚌", "🚐", "🚛", "🛳", "🚑", "🚜"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) {pairIndex in emojis[pairIndex]}
    }

    // keywork published will automatically do
    // objectWillChange.send() anytime this var changes
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
