//
//  ThinkFastGameView.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//


import SwiftUI

struct ThinkFastGameView: View {
    @Environment(ThinkFastViewModel.self) private var viewModel
    
    var body: some View {
        ZStack {
            Image("bg2")
                .resizable()
                .ignoresSafeArea()
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 20) {
                GameHeader(viewModel: viewModel)
                Spacer()
                CardsGrid()
               Spacer()
            }
            .padding()
            if viewModel.isGameOver || viewModel.isGameWon {
                ResultOverlay(viewModel: viewModel) {
                    viewModel.startNewGame()
                }
                Spacer()
            }
            Spacer()
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}
