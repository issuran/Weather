//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBack(_ sender: Any) {
        coordinator?.start()
    }
}
