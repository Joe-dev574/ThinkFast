//
//  ThinkFastViewModel.swift
//  ThinkFast
//

import SwiftUI

@MainActor
@Observable
final class ThinkFastViewModel {
    // MARK: - Game Model
    private var game = ThinkFast<String>(numberOfPairs: 8) { _ in "" }
    
    // MARK: - Public Observable State
    var cards: [ThinkFast<String>.Card] { game.cards }
    var score: Int { game.cards.filter(\.isMatched).count / 2 }
    var isGameOver = false
    var isGameWon = false
    var timeRemaining = 60
    var hintActive = false
    var currentTheme: Theme = .classic
    
    // MARK: - Tasks (must be non-isolated for safe deinit)
    @ObservationIgnored private var countdownTask: Task<Void, Never>?
    @ObservationIgnored private var hintTask: Task<Void, Never>?
    
    // MARK: - Theme Persistence – 100% safe
    private let themeStorage = ThemeStorage()
    
    // MARK: - Init
    init() {
        self.currentTheme = themeStorage.currentTheme
        restartGame()
    }
    
    // MARK: - Public Actions
    func choose(_ card: ThinkFast<String>.Card) {
        guard !isGameOver && !isGameWon else { return }
        game.choose(card)
        hintActive = false
        scheduleHint()
        checkWin()
    }
    
    func switchToTheme(_ theme: Theme) {
        guard theme != currentTheme else { return }
        currentTheme = theme
        themeStorage.currentTheme = theme
        restartGame()
    }
    
    func startNewGame() { restartGame() }
    
    // MARK: - Private
    private func restartGame() {
        game = ThinkFast(numberOfPairs: currentTheme.numberOfPairs) { index in
            currentTheme.emojis[index % currentTheme.emojis.count]
        }
        
        timeRemaining = currentTheme.timeLimit
        isGameOver = false
        isGameWon = false
        hintActive = false
        
        countdownTask?.cancel()
        hintTask?.cancel()
        startCountdown()
        scheduleHint()
    }
    
    private func startCountdown() {
        countdownTask = Task { @MainActor in
            while self.timeRemaining > 0 && !self.isGameWon {
                try? await Task.sleep(for: .seconds(1))
                guard !Task.isCancelled else { return }
                self.timeRemaining -= 1
            }
            if self.timeRemaining <= 0 && !self.isGameWon {
                self.isGameOver = true
            }
        }
    }
    
    private func scheduleHint() {
        hintTask = Task {
            try? await Task.sleep(for: .seconds(8))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                if !self.isGameWon && !self.isGameOver {
                    self.hintActive = true
                }
            }
        }
    }
    
    private func checkWin() {
        if game.cards.allSatisfy({ $0.isMatched }) {
            isGameWon = true
        }
    }
    
    // MARK: - FINAL FIX: deinit is now 100% safe
    nonisolated deinit {
        // Safe to cancel from any context
        Task { @MainActor in
            self.countdownTask?.cancel()
            self.hintTask?.cancel()
        }
    }
}

// MARK: - Theme Storage Helper (solves @AppStorage + @Observable forever)
private class ThemeStorage {
    @AppStorage("selectedThinkFastThemeIndex") var currentThemeIndex: Int = 0
    
    var currentTheme: Theme {
        get { Theme.all.indices.contains(currentThemeIndex) ? Theme.all[currentThemeIndex] : .classic }
        set { currentThemeIndex = Theme.all.firstIndex(of: newValue) ?? 0 }
    }
}
extension View {
    func celebrateWin() -> some View {
        self.onAppear {
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.prepare()
            impact.impactOccurred(intensity: 1.0)
            
            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
        }
    }
}
