//
//  GetSightingsWorker.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import Foundation

class GetSightingsWorker {
    var downloader = FlowersDownloader()

    func execute(flowerId: Int, success: RestClient.SuccessCompletion<[Sighting]>, failure: RestClient.FailureCompletion) {
        downloader.fetchFlowerSightings(flowerId: flowerId, success: success, failure: failure)
    }
}
