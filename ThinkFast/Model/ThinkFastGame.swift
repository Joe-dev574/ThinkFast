//
//  ThinkFastGame.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI
import Foundation

struct ThinkFast<CardContent: Equatable> {
    private(set) var cards: [Card]
    
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else { return }
        
        if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            cards[chosenIndex].isFaceUp = true
        } else {
            indexOfTheOnlyFaceUpCard = chosenIndex
        }
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairs {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable, Equatable {
        let id = UUID()
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
}

extension Array {
    var only: Element? { count == 1 ? first : nil }
}
