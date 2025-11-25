//
//  Theme.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//


import Foundation
import SwiftUI

struct Theme: Hashable {
    let id = UUID()
    let name: String
    let emojis: [String]
    let numberOfPairs: Int // overrides emoji count if needed
    let timeLimit: Int      // seconds
    let gradientColors: [Color]
    let gridColumns: Int
    
    var cardCount: Int { numberOfPairs * 2 }
    
    static let all: [Theme] = [
        .classic,
        .animals,
        .food,
        .halloween,
        .space,
        .nature
    ]
    
    static let classic = Theme(
        name: "Classic",
        emojis: ["🚀", "🌕", "🚙", "🦄", "🌈", "🌎", "🦋", "🌹"],
        numberOfPairs: 8,
        timeLimit: 60,
        gradientColors: [.pink, .purple],
        gridColumns: 4
    )
    
    static let animals = Theme(
        name: "Animals",
        emojis: ["🐶", "🐱", "🐘", "🦁", "🐅", "🙈", "🐧", "🐨", "🐼", "🦊"],
        numberOfPairs: 10,
        timeLimit: 80,
        gradientColors: [.orange, .yellow],
        gridColumns: 4
    )
    
    static let food = Theme(
        name: "Food & Drinks",
        emojis: ["🍕", "🍔", "🌮", "🍱", "🍦", "🍩", "🍿", "☕️", "🥐", "🍉"],
        numberOfPairs: 10,
        timeLimit: 70,
        gradientColors: [.red, .orange],
        gridColumns: 5
    )
    
    static let halloween = Theme(
        name: "Halloween",
        emojis: ["👻", "🎃", "🦇", "🕷️", "💀", "🧙‍♀️", "🐈‍⬛", "🍬", "☠️", "🌖"],
        numberOfPairs: 9,
        timeLimit: 65,
        gradientColors: [.purple, .black],
        gridColumns: 3
    )
    
    static let space = Theme(
        name: "Space",
        emojis: ["🚀", "👽", "🛰️", "🌍", "💫", "☄️", "👩‍🚀", "🔭", "⭐️", "🛸"],
        numberOfPairs: 12,
        timeLimit: 90,
        gradientColors: [.blue, .indigo],
        gridColumns: 4
    )
    
    static let nature = Theme(
        name: "Nature",
        emojis: ["🌲", "⛰️", "🌞", "⛅️", "☔️", "🍁", "🌵", "🍄", "🍍", "🪴"],
        numberOfPairs: 10,
        timeLimit: 75,
        gradientColors: [.green, .teal],
        gridColumns: 4
    )
}
