//
//  MemoryGame.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // on init:
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards * 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func choose(_ card: Card) {
        // if we can find the passed in card
        // and it is not face up
        // and it has not been matched
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id})
            ,!cards[chosenIndex].isFaceUp
            ,!cards[chosenIndex].isMatched
        {
            // if we have previously set indexOfTheOneAndOnlyFaceUpCard
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // if newly chosen cards content matches previously chosen cards content
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // then we have found a match
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // non matching card selected
                // set all cards as face down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                // and remember index of currently selected card
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            // toggle faceUp state
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
