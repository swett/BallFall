//
//  GameViewModel.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import Foundation

class GameViewModel: ObservableObject,GameSceneDelegate {
    @Published var gameState: GameState = .notStarted
    @Published var gameTime: TimeInterval = 30
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
}


extension GameViewModel {
    func popToMain() {
        coordinator?.popOneScreenBack()
    }
}

extension GameViewModel {
    func startGame() {
        gameTime = 30
        gameState = .playing
    }
    
    func gameOver(won: Bool) {
        gameState = won ? .won : .lost
    }
    
    func resetGame() {
        gameState = .notStarted
    }
    func updateTimer(timeRemaining: TimeInterval) {
        gameTime = timeRemaining
    }
}

enum GameState {
    case notStarted
    case playing
    case won
    case lost
}


