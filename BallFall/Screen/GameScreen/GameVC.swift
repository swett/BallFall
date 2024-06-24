//
//  GameVC.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import UIKit
import SwiftUI

class GameVC: UIHostingController<GameView> {
    
    var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(rootView: GameView(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
