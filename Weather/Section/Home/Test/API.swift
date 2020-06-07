//
//  API.swift
//  Weather
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation
import Aquino

enum SignWebScrapAPI {
    case today(sign: String)
}

extension SignWebScrapAPI: ServiceProtocol {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "joaobidu.com.br"
    }
    
    var path: String {
        switch self {
        case .today(let sign):
            return "/horoscopo/signos/previsao-\(sign)"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var task: HttpTask {
        return .request
    }
}
