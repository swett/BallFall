//
//  Coordinator.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//
import UIKit
protocol CoordinatorProtocol {
    var rootViewController: UIViewController? { get }
    func showPreloader()
    func showGameScreen()
    func popOneScreenBack()
    func hidePopUpScreens()
}

final class Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: NavigationVC) {
        self.navigationController = navigationController
    }
    
    
}


extension Coordinator: CoordinatorProtocol {
    
    var rootViewController: UIViewController? {
        navigationController
    }
    
    
    func showPreloader() {
        let viewModel = PreloaderViewModel(coordinator: self)
        let preloaderVC = PreloaderVC(viewModel: viewModel)
        navigationController.pushViewController(preloaderVC, animated: true)
    }
    
    func showGameScreen() {
        let viewModel = GameViewModel(coordinator: self)
        let gameVC = GameVC(viewModel: viewModel)
        navigationController.pushViewController(gameVC, animated: true)
    }
    
    
    func popOneScreenBack() {
        navigationController.popViewController(animated: true)
    }
    
    func hidePopUpScreens() {
        navigationController.viewControllers.last?.dismiss(animated: true, completion: nil)
    }
    
}
