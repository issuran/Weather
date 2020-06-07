//
//  Service.swift
//  Weather
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation
import Aquino

class SignScrapService: Provider {
    
    let provider = Provider()
    
    func getSignToday(sign: String,
                      completion: @escaping (Result<SignDetailsModel?>) -> Void) -> Void {
        
        do {
            try provider.execute(endpoint: SignWebScrapAPI.today(sign: sign)) { (result) in
                switch result {
                case .success(_, let response):
                    let model = SignDetailsModel(texto: "Libra", autor: "Autor")
                    completion(.success(model, response))
                case .failure(let error):
                    completion(.failure(error))
                case .empty:
                    completion(.empty)
                }
            }
        } catch {
            completion(.empty)
        }
    }
}
