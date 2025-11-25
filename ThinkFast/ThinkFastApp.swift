//
//  ThinkFastApp.swift
//  ThinkFast
//
//  Created by Joseph DeWeese on 11/25/25.
//

import SwiftUI

@main
struct ThinkFastApp: App {
    @State private var viewModel = ThinkFastViewModel()
    
    var body: some Scene {
        WindowGroup {
            ThinkFastGameView()
                .environment(viewModel)
        }
    }
}
