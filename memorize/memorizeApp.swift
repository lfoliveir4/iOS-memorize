//
//  memorizeApp.swift
//  memorize
//
//  Created by Luis Filipe Alves de Oliveira on 17/04/21.
//

import SwiftUI

@main
struct memorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
