//
//  GameHeader.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI

struct GameHeader: View {
    let viewModel: ThinkFastViewModel
    
    var body: some View {
        HStack {
            Button(
                action: {},
                label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        Text("Back")
                            .font(.custom("Bebas Neue", size: 25))
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                    }
                }
            )
            .foregroundColor(.yellow)
            .padding(.horizontal, 7)
            Spacer()
            VStack{
                Text("Think Fast")
                    .font(.custom("Bebas Neue", size: 35))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(.orange)
                    .padding(.horizontal)
                //Timer
                Text("\(viewModel.timeRemaining.formattedTime)")
                    .foregroundStyle(viewModel.timeRemaining < 30 ? .red : .yellow)
                    .font(.custom("Bebas Neue", size: 40).bold())
                
//                if viewModel.hintActive {
//                    Text("Hint: Tap a card")
//                        .foregroundStyle(.yellow)
//                        .font(.custom("Bebas Neue", size: 30).bold())
//                }
                
            }
            Spacer()
            
            VStack{
                Text("Score: \(viewModel.score)")
                    .font(.custom("Bebas Neue", size: 30))
                    .foregroundStyle(.green)
                    .padding(.horizontal,12)
                    .fontWeight(.bold)
                
            }
        }
        Spacer()
    }
}
#Preview {
    GameHeader(viewModel: ThinkFastViewModel())
}

extension Int {
    var formattedTime: String {
        String(format: "%02d:%02d", self / 60, self % 60)
    }
}
