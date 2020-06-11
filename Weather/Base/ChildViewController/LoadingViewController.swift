//
//  LoadingViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 11/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.center = view.center
    }
}
