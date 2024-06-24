//
//  NavigationVC.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import UIKit

class NavigationVC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        
        
        navigationBar.tintColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isHidden = false
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
