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
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
}

extension EmojiMemoryGameView {
    
    // MARK: Components
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            //  Rectangle().opacity(0.0)
            Color.clear // creates a clear rectangle
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
    }
    
    private var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
            cardView(for: card)
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
    }
    
    private var shuffle: some View{
        Button("Shuffle") {
            game.shuffle()
        }
    }
}

// CardView struct returns a rounded rectangle
// with some emoji string centered inside of it
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                Pie(
                    startAngle: Angle(degrees: 0-90),
                    endAngle: Angle(degrees: 50-90)
                )
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    // Returns Scaled Font
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
 
    // CONSTANTS
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
        
        static let piePadding: CGFloat = 7
        static let pieOpacity: CGFloat = 0.5
    }
}

// Preview struct
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 12 mini")
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
