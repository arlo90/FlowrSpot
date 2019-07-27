//
//  UIView+Extra.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit

extension UIView {
    static func loadView<T: Identifiable>() -> T {
        if let view = Bundle.main.loadNibNamed(T.identifier, owner: self, options: nil)?.first as? T {
            return view
        } else {
            fatalError("Failed to load view with identifier: \(T.identifier)")
        }
    }
}

extension UIView: Identifiable {
    
}
