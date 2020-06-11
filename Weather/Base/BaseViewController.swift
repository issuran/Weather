//
//  BaseViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AppCoordinator?
    
    let loadingVC = LoadingViewController()
    
    func startLoading() {
        DispatchQueue.main.async {
            self.add(self.loadingVC)
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingVC.remove()
        }
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
