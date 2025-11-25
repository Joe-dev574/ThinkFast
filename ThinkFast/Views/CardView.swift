//
//  CardView.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI

struct CardView: View {
    let card: ThinkFast<String>.Card
    let theme: Theme
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if card.isFaceUp || card.isMatched {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text(card.content)
                        .font(.system(size: min(geo.size.width, geo.size.height) * 0.6))
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom))
                    Image("ThinkFastCard")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                }
            }
            .rotation3DEffect(
                .degrees(card.isFaceUp ? 0 : 180),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(card.isMatched ? 0 : 1)
        }
    }
}

