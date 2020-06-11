//
//  String+Utils.swift
//  Weather
//
//  Created by Tiago Oliveira on 11/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
