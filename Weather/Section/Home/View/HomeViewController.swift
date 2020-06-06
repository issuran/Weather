//
//  HomeViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func goNext(_ sender: Any) {
        coordinator?.currentWeather()
    }
}
