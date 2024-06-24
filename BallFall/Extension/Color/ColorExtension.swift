//
//  ColorExtension.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import UIKit
import SwiftUI


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let backgroundColor: UIColor = UIColor(hexString: "#0E0618")
    static let platformOneColor: UIColor = UIColor(hexString: "#FC3D60")
    static let platformTwoColor: UIColor = UIColor(hexString: "#FC4680")
}




extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    let mainTextColor = Color(hex: "#FFFFFF")
    let pinkText = Color(hex:"#FF6897")
    let deteilsTextColor = Color(hex: "#A69DB9")
//    let buttonColor = Color(hex: "#FAFF00")
//    let buttonTextColor = Color(hex: "#FFFFFF")
    let buttonGradientOne = Color(hex: "#FC3D60")
    let buttonGradientTwo = Color(hex: "#FC4680")
    let backgroundColor = Color(hex: "#0E0618")
}
