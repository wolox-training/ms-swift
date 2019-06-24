//
//  UIButtonExtension.swift
//  WBooks
//
//  Created by Matías David Schwalb on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import WolmoCore

public extension UIButton {
  
    func setWGradient(isEnabled: Bool) {
        if isEnabled {
            self.gradient =  ViewGradient(colors: [.wGradientLeftColor, .wGradientRightColor], direction: .leftToRight)
        } else {
            self.gradient = .none
        }
    }
    
}
