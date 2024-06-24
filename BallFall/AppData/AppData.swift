//
//  AppData.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import Foundation
class AppData: NSObject {
    
    fileprivate override init() {
        super.init()
        if !UserDefaults.standard.bool(forKey: "isDataLoaded"){
            defaultLoad()
            UserDefaults.standard.set(true, forKey: "isDataLoaded")
        }   else {
            loadData()
            
            
        }
        
    }
    
    var defaultData: UserDefaults = UserDefaults.standard
    var savedPlayersTurns: WinLoseModel?
    
    static let shared: AppData = AppData()
}



extension AppData {
    func defaultLoad() {

    }
    
    func loadData() {
        savedPlayersTurns = getPlayerResults()
    }
}

  
extension AppData {
    func savePlayerResults() {
           let encoder = JSONEncoder()
           let key = Keys.playerTurns
           guard let data = try? encoder.encode(savedPlayersTurns) else {
               return
           }
           defaultData.set(data, forKey: key)
       }
       
       func getPlayerResults() -> WinLoseModel {
           let decoder = JSONDecoder()
           let key = Keys.playerTurns
           savedPlayersTurns = try! decoder.decode(WinLoseModel.self, from: defaultData.data(forKey: key)!)
           return savedPlayersTurns!
       }
}

