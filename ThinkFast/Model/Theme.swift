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
        emojis: ["Rocket", "Moon", "Car", "Unicorn", "Rainbow", "Earth", "Butterfly", "Flower"],
        numberOfPairs: 8,
        timeLimit: 60,
        gradientColors: [.pink, .purple],
        gridColumns: 4
    )
    
    static let animals = Theme(
        name: "Animals",
        emojis: ["Dog", "Cat", "Elephant", "Lion", "Tiger", "Monkey", "Penguin", "Koala", "Panda", "Fox"],
        numberOfPairs: 10,
        timeLimit: 80,
        gradientColors: [.orange, .yellow],
        gridColumns: 4
    )
    
    static let food = Theme(
        name: "Food & Drinks",
        emojis: ["Pizza", "Burger", "Taco", "Sushi", "Ice Cream", "Donut", "Popcorn", "Coffee", "Croissant", "Watermelon"],
        numberOfPairs: 10,
        timeLimit: 70,
        gradientColors: [.red, .orange],
        gridColumns: 5
    )
    
    static let halloween = Theme(
        name: "Halloween",
        emojis: ["Ghost", "Pumpkin", "Bat", "Spider", "Skull", "Witch", "Black Cat", "Candy", "Grave", "Moon"],
        numberOfPairs: 9,
        timeLimit: 65,
        gradientColors: [.purple, .black],
        gridColumns: 3
    )
    
    static let space = Theme(
        name: "Space",
        emojis: ["Rocket", "Alien", "Satellite", "Planet", "Star", "Comet", "Astronaut", "Telescope", "Black Hole", "UFO"],
        numberOfPairs: 12,
        timeLimit: 90,
        gradientColors: [.blue, .indigo],
        gridColumns: 4
    )
    
    static let nature = Theme(
        name: "Nature",
        emojis: ["Tree", "Mountain", "Sun", "Cloud", "Rain", "Leaf", "Cactus", "Mushroom", "Pineapple", "Herb"],
        numberOfPairs: 10,
        timeLimit: 75,
        gradientColors: [.green, .teal],
        gridColumns: 4
    )
}
