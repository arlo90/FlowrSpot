//
//  File.swift
//  FlowrSpotTests
//
//  Created by TK on 22/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import Foundation
@testable import FlowrSpot

class FlowersDataMock {
  let decoder = JSONDecoder()
  
  init() {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
  
  func mockFlowerEntities() -> [Flower] {
    return FlowerResponseMapper.map(response: mockFlowerResponses())
  }
  
  func mockFlowerResponses() -> [FlowerResponse] {
    do {
      let json = try laodJsonFromFile("flowers")
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      let container = try decoder.decode(FlowersContainer.self, from: data)
      return container.flowers
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
}

private extension FlowersDataMock {
  func laodJsonFromFile(_ file: String) throws -> Any {
    guard let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else { throw RemoteResourceError.generic }
    
    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
    return jsonResult
  }
}
