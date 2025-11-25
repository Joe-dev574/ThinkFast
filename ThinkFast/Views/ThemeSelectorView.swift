//
//  ThemeSelectorView.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI

// Views/Components/ThemeSelectorView.swift
struct ThemeSelectorView: View {
    @Environment(ThinkFastViewModel.self) private var viewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Choose Theme")
                .font(.title2.bold())
                .foregroundStyle(.white)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 12) {
                ForEach(Theme.all, id: \.self) { theme in
                    Button {
                        withAnimation(.spring()) {
                            viewModel.switchToTheme(theme)
                        }
                    } label: {
                        VStack(spacing: 8) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(colors: theme.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 80)
                                .overlay {
                                    Text(theme.emojis.randomElement() ?? "Star")
                                        .font(.system(size: 40))
                                }
                            
                            Text(theme.name)
                                .font(.caption)
                                .foregroundStyle(.white)
                        }
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(viewModel.currentTheme == theme ? Color.white.opacity(0.2) : Color.clear)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
}
#Preview {
    ThemeSelectorView()
}
