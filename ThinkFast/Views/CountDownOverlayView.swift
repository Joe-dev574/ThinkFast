//
//  CountdownOverlayView.swift
//  ThinkFast
//

import SwiftUI

struct CountdownOverlayView: View {
    @EnvironmentObject private var viewModel: ThinkFastViewModel

    
    var body: some View {
        if viewModel.isCountdownActive {
            ZStack {
                // Dark backdrop
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                // The big number or "GO!"
                if viewModel.countdownNumber > 0 {
                    Text("\(viewModel.countdownNumber)")
                        .font(.system(size: 200, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.6), radius: 30, x: 0, y: 15)
                        .scaleEffect(viewModel.countdownNumber == 3 ? 0.7 : 1.1)
                        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: viewModel.countdownNumber)
                } else {
                    Text("GO!")
                        .font(.system(size: 180, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.yellow, .orange, .red],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .orange.opacity(0.9), radius: 40)
                        .scaleEffect(1.5)
                        .rotationEffect(.degrees(8))
                        .animation(.spring(response: 0.7, dampingFraction: 0.5), value: viewModel.countdownNumber)
                }
            }
            .zIndex(999) // Always on top of everything
            .transition(.scale.combined(with: .opacity))
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.purple.ignoresSafeArea()
        CountdownOverlayView()
          
    }
}
