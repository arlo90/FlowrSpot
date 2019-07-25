//
//  FlowersWorker.swift
//  FlowrSpot
//
//  Created by TK on 18/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import Foundation

class GetFlowersWorker {
  var downloader = FlowersDownloader()
  
  func execute(success: RestClient.SuccessCompletion<[Flower]>, failure: RestClient.FailureCompletion) {
    downloader.fetchFlowersList(success: success, failure: failure)
  }
}
