//
//  Storyboarded.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

enum StoryboardsPath: String{
    case Home = "Home"
    case CurrentWeather = "CurrentWeather"
}

protocol Storyboarded {
    static func instantiate(_ storyboardId: StoryboardsPath) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardId: StoryboardsPath) -> Self {
        let id = String(describing: self)
        /// carrega o storyboard
        var storyboard = UIStoryboard()
        switch storyboardId {
        case .Home:
            storyboard = UIStoryboard(name: StoryboardsPath.Home.rawValue ,bundle: Bundle.main)
        case .CurrentWeather:
            storyboard = UIStoryboard(name: StoryboardsPath.CurrentWeather.rawValue ,bundle: Bundle.main)
        }
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
