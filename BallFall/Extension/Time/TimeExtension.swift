//
//  TimeExtension.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 24.06.2024.
//

import Foundation
func timeString(time: TimeInterval) -> String {
    let hour = Int(time) / 3600
    let minute = Int(time) / 60 % 60
    let second = Int(time) % 60
    
    // return formated string
    if hour > 0 {
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    } else {
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
    
}

func timeStringOnlyMinutesandSeconds(time: TimeInterval) -> String {
    let minute = Int(time) / 60 % 60
    let second = Int(time) % 60
    
    return String(format: "%02i:%02i", minute, second)
    
}
