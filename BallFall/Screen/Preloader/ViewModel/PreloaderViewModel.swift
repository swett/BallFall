//
//  PreloaderViewModel.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import Foundation
class PreloaderViewModel: ObservableObject {
    @Published var isDowloading: Bool = true
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
}


extension PreloaderViewModel {
    func showMain() {
        coordinator?.showGameScreen()
    }
}


extension PreloaderViewModel {
    func callApi() {
        if AppData.shared.savedPlayersTurns == nil {
            getWiinerOrLoser(url: URL(string: "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod")!) { result in
                switch result {
                case .success(let success):
                    AppData.shared.savedPlayersTurns = success
                    AppData.shared.savePlayerResults()
                    self.isDowloading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showMain()
                    }
                case .failure(let failure):
                    print("Error fetching leagues: \(failure)")
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.showMain()
            }
        }
        
        
    }
}
