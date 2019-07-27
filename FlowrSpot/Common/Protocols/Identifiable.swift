//
//  Identifiable.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".")[1]
    }
}
