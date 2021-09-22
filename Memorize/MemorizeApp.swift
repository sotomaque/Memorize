//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/21/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
