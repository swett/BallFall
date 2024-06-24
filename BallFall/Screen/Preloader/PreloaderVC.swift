//
//  PreloaderVC.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import UIKit
import SwiftUI
class PreloaderVC: UIHostingController<PreloaderView> {
    
    var viewModel: PreloaderViewModel
    
    init(viewModel: PreloaderViewModel) {
        self.viewModel = viewModel
        super.init(rootView: PreloaderView(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
