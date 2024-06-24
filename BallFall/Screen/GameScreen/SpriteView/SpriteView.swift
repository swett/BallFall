//
//  SpriteView.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

//import SwiftUI
//import SpriteKit
//
//struct SpriteView: UIViewRepresentable {
//    @Binding var gameState: GameState
//    
//    class Coordinator: NSObject, GameSceneDelegate {
//        var parent: SpriteView
//        
//        init(parent: SpriteView) {
//            self.parent = parent
//        }
//        
//        func gameOver(won: Bool) {
//            DispatchQueue.main.async {
//                self.parent.gameState = won ? .won : .lost
//            }
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIView(context: Context) -> SKView {
//        let view = SKView()
//        let scene = GameScene(size: UIScreen.main.bounds.size)
//        scene.scaleMode = .resizeFill
//        scene.gameDelegate = context.coordinator
//        view.presentScene(scene)
//        return view
//    }
//    
//    func updateUIView(_ uiView: SKView, context: Context) {}
//}
//
