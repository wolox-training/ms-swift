//
//  WColor.swift
//  WBooks
//
//  Created by Matías David Schwalb on 03/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

extension UIColor {
    static let wOliveGreen = UIColor(displayP3Red: 172.0 / 255.0, green: 194.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
    
    static let wBlue = UIColor(displayP3Red: 88.0 / 255.0, green: 160.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
    
    static let wLightBlue = UIColor(displayP3Red: 231.0 / 255.0, green: 245.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    
    static let wRentedYellow = UIColor(displayP3Red: 255.0 / 255.0, green: 211.0 / 255.0, blue: 0.0, alpha: 1.0)
    
    static let wGradientLeftColor = UIColor(displayP3Red: 0.0 / 255.0, green: 164.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
    
    static let wGradientRightColor = UIColor(displayP3Red: 49.0 / 255.0, green: 197.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
    
    func RGBColor(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
