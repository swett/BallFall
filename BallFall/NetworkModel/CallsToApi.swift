//
//  CallsToApi.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import Foundation
import Alamofire

func getWiinerOrLoser(url: URL,completion: @escaping (Result<WinLoseModel, Error>) -> Void) {

        let headers: HTTPHeaders = []
        
        AF.request(url, method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: WinLoseModel.self) { response in
            switch response.result {
            case .success(let winLoseResponse):
                completion(.success(winLoseResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
