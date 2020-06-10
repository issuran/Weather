//
//  HomeViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit
import Keys

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func goNext(_ sender: Any) {
        let keys = WeatherKeys()
        debugPrint(keys.apiKey)
        coordinator?.currentWeather()
        
        /// Testando framework
        let service = SignScrapService()
        service.getSignToday(sign: "Libra") { (result) in
            switch result {
            case .success(_, _):
                print("Sucesso")
            case .failure(_):
                print("Failure")
            case .empty:
                print("Empty")
            }
        }
        /// Fim do teste
    }
}
