//
//  ContentView.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import SwiftUI

struct ContentView: View {
    
    // Properties
    var emojis = ["✈️", "🚀", "🚗", "🚘", "🚙", "🛫", "🛬", "🏎", "🛵", "🏍", "🚌", "🚐", "🚛", "🛳", "🚑", "🚜"]
    @State var emojiCount = 6
    
    // Return a Vertical ScrollView
    // with a nested grid of cards
    // and a horizontal stack containing
    // buttons to add or remove cards
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        }
        .padding(.horizontal)
    }
}

// CardView struct returns a rounded rectangle
// with some emoji string centered inside of it
struct CardView: View {
    
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

// Preview struct
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
    }
}
