//
//  CardsGridView.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI

struct CardsGrid: View {
    @Environment(ThinkFastViewModel.self) private var viewModel
    
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 12), count: viewModel.currentTheme.gridColumns)
    }
    
    var body: some View {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, theme: viewModel.currentTheme)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4)) {
                                viewModel.choose(card)
                            }
                        }
                }
            }
            .padding()
        }
    }
