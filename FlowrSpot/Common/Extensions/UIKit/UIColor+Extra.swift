//
//  UIColor+Extra.swift
//  CoinMarket
//
//  Created by TK on 04/11/2017.
//  Copyright © 2017 TK. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
    self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
  }
}

// MARK: - Theme Colors

extension UIColor {
    static let flowrGray = UIColor(r: 148, g: 158, b: 160)
    static let flowrPink = UIColor(r: 223, g: 145, b: 134)
    static let flowrBeige = UIColor(r: 236, g: 188, b: 179)
    static let flowrBlush = UIColor(r: 234, g: 167, b: 158)
    static let flowrPinkishTan = UIColor(r: 223, g: 145, b: 134)
    static let flowrCharcoalGray = UIColor(r: 51, g: 65, b: 68)
}
