//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["✈️", "🚀", "🚗", "🚘", "🚙", "🛫", "🛬", "🏎", "🛵", "🏍", "🚌", "🚐", "🚛", "🛳", "🚑", "🚜"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) {pairIndex in emojis[pairIndex]}
    }

    // keywork published will automatically do
    // objectWillChange.send() anytime this var changes
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        withAnimation {
            model.shuffle()
        }
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
