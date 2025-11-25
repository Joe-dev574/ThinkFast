//
//  ResultOverlayView.swift
//  ThinkFast
//
//  Updated with confetti + haptics + preview
//

import SwiftUI

struct ResultOverlay: View {
    let viewModel: ThinkFastViewModel
    let onReplay: () -> Void
    
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            // Background blur + dim
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture { } // prevent taps behind
            
            VStack(spacing: 30) {
                // Trophy / Celebration Image
                Image("ThinkFastGame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: .yellow.opacity(0.8), radius: viewModel.isGameWon ? 30 : 0)
                    .scaleEffect(viewModel.isGameWon ? 1.2 : 1.0)
                    .animation(.spring(response: 0.6, dampingFraction: 0.6), value: viewModel.isGameWon)
                
                // Title
                Text(viewModel.isGameWon ? "YOU WIN!" : "Game Over")
                    .font(.system(size: 52, weight: .bold, design: .rounded))
                    .foregroundStyle(viewModel.isGameWon ? .yellow : .white)
                    .shadow(radius: 10)
                    .scaleEffect(viewModel.isGameWon ? 1.3 : 1.0)
                    .animation(.spring(response: 0.8), value: viewModel.isGameWon)
                
                // Bonus points
                if viewModel.isGameWon {
                    Text("+\(viewModel.timeRemaining / 5) Bonus Points!")
                        .font(.title2.bold())
                        .foregroundStyle(.yellow)
                        .shadow(color: .black.opacity(0.5), radius: 4)
                    
                }
                
                // Final Score
                Text("Final Score: \(viewModel.score + (viewModel.isGameWon ? viewModel.timeRemaining / 5 : 0))")
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.9))
                
                // Buttons
                HStack(spacing: 40) {
                    Button("Menu") {
                        // Handle menu (dismiss or navigate)
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Play Again") {
                        withAnimation {
                            showConfetti = false
                        }
                        onReplay()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
                .font(.title3.bold())
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(viewModel.isGameWon ? Color.yellow.opacity(0.6) : Color.white.opacity(0.3), lineWidth: 3)
                    )
            )
            .shadow(radius: 20)
            .padding(.horizontal, 30)
            
            // CONFETTI EXPLOSION (only on win)
            if viewModel.isGameWon {
                ConfettiView()
                    .allowsHitTesting(false)
                    .transition(.opacity)
            }
        }
        .onChange(of: viewModel.isGameWon) {
            if viewModel.isGameWon {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    showConfetti = true
                }
                
                // Victory haptics
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                
                // Confetti-like vibration burst
                for i in 0..<10 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.12) {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.8)
                    }
                }
            }
        }
    }
}
