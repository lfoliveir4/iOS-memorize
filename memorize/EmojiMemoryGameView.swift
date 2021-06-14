//
//  EmojiMemoryGameView.swift
//  memorize
//
//  Created by Luis Filipe Alves de Oliveira on 17/04/21.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    let defaultColor = Color.orange
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in CardView(card: card).onTapGesture {
                withAnimation(.linear) {
                    viewModel.chooseCard(card: card)
                }
            }.padding(5)
            
        }.padding().foregroundColor(defaultColor)
            
            Button(action: { withAnimation(.easeOut) {
                self.viewModel.resetGame()
            }}, label: { Text("Novo Jogo") }).padding(15)
            
        }
    }
}



struct CardView: View {
    var card: MemoryGame<String>.Card
    
    // MARK: - Drawing constants

        
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusremaing: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusremaing = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusremaing = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusremaing*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }.padding(5).opacity(0.4).transition(.identity)

                
                Text(self.card.content)
                        .font(Font.system(size: fontSize(for: size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
