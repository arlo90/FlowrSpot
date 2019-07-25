//
//  FlowersDownloader.swift
//  FlowrSpot
//
//  Created by TK on 22/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import Foundation

final class FlowersDownloader {
  let restClient: RestClient
  
  init(restClient: RestClient = .shared) {
    self.restClient = restClient
  }
}

extension FlowersDownloader {
  func fetchFlowersList(success: RestClient.SuccessCompletion<[Flower]>, failure: RestClient.FailureCompletion) {
    restClient.request(FlowersContainer.self, FlowerRequests.flowersList, version: Version.v1, success: {
      success?($0.flowers)
    }, failure: failure)
  }
  
  func fetchFlowerDetails(flowerId: Int, success: RestClient.SuccessCompletion<Flower>, failure: RestClient.FailureCompletion) {
    restClient.request(Flower.self, FlowerRequests.flowerDetails(flowerid: flowerId), version: .v1, success: success, failure: failure)
  }
}
