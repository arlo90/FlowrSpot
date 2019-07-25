//
//  SectionType.swift
//  FlowrSpot
//
//  Created by TK on 18/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import PovioKit

protocol SectionType {
  associatedtype Row: RowType
  var rows: [Row] { get }
}

extension SectionType {
  func row(at index: Int) -> Self.Row? {
    return rows[safe: index]
  }
}
