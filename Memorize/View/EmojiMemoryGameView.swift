//
//  ContentView.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // @ObservedObject will redraw view if var changes
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
}

// CardView struct returns a rounded rectangle
// with some emoji string centered inside of it
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

// Preview struct
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 12 mini")
    }
}
