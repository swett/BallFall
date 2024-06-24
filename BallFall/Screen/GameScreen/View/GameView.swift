//
//  GameView.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import SwiftUI
import SpriteKit
struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var timer: Timer?
    @State private var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }()
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.backgroundColor
                .ignoresSafeArea(.all)
            
            if viewModel.gameState == .notStarted {
                VStack {
                    Spacer()
                    Button {
                        viewModel.startGame()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            scene.startGame()
                        }
                        
                    } label: {
                        LinearGradient(colors: [Color.theme.buttonGradientOne, Color.theme.buttonGradientTwo], startPoint: .top, endPoint: .bottom)
                            .frame(width: 358, height: 58)
                            .cornerRadius(33)
                            .overlay {
                                Text("Start Game")
                                    .foregroundStyle(Color.theme.mainTextColor)
                                    .font(.title)
                            }
                    }
                    
                }
                
            } else if viewModel.gameState == .playing {
                SpriteView(scene: scene)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            } else if viewModel.gameState == .won {
                WebView(url: URL(string: AppData.shared.savedPlayersTurns?.winner ?? "")!, gameState: $viewModel.gameState)
                    .edgesIgnoringSafeArea(.all)
            } else if viewModel.gameState == .lost {
                WebView(url: URL(string: AppData.shared.savedPlayersTurns?.loser ?? "")!, gameState: $viewModel.gameState)
                    .edgesIgnoringSafeArea(.all)
            }
            VStack {
                header
            }
        }
        .onAppear {
            scene.gameDelegate = viewModel
            viewModel.resetGame()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}


extension GameView {
    private var header: some View {
        HStack {
            if viewModel.gameState == .playing {
                Text("\(timeStringOnlyMinutesandSeconds(time: TimeInterval(viewModel.gameTime)))")
                    .foregroundStyle(Color.theme.mainTextColor)
                    .font(.title)
            }
        }
    }
}
