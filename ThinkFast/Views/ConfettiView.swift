//
//  ConfettiView.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI

struct ConfettiView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<50, id: \.self) { _ in
                ConfettiParticle()
                    .opacity(animate ? 1 : 0)
                    .animation(
                        Animation.linear(duration: Double.random(in: 2...4))
                            .delay(Double.random(in: 0...1)),
                        value: animate
                    )
            }
        }
        .onAppear {
            withAnimation { animate = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation { animate = false }
            }
        }
    }
}

struct ConfettiParticle: View {
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = -1000
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    
    private let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink]
    
    var body: some View {
        Circle()
            .fill(colors.randomElement()!)
            .frame(width: CGFloat.random(in: 8...16), height: CGFloat.random(in: 8...16))
            .offset(x: CGFloat.random(in: -200...200), y: yOffset)
            .rotationEffect(.degrees(rotation))
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeOut(duration: Double.random(in: 2...4))) {
                    yOffset = UIScreen.main.bounds.height + 100
                    xOffset = CGFloat.random(in: -300...300)
                    rotation = Double.random(in: 360...1440)
                    scale = 0.3
                }
            }
    }
}
