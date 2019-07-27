//
//  DetailInteractor.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import Foundation

protocol DetailBusinessLogic {
    func fetchFlower(flowerId: Int)
}

class DetailInteractor {
    var presenter: DetailPresentationLogic?
    var getFlowersWorker = GetFlowersWorker()
    var getSightingsWorker = GetSightingsWorker()
}

// MARK: - Business Logic
extension DetailInteractor: DetailBusinessLogic {
    func fetchFlower(flowerId: Int) {
        let dispatchGroup = DispatchGroup()
        
        var flower: Flower?
        var sightings: [Sighting]?
        
        // Flower details
        dispatchGroup.enter()
        getFlowersWorker.execute(flowerId: flowerId, success: { (result) in
            flower = result
            dispatchGroup.leave()
        }, failure: { error in
            print(error)
            dispatchGroup.leave()
        })
        
        // Sightings
        dispatchGroup.enter()
        getSightingsWorker.execute(flowerId: flowerId, success: { (results) in
            sightings = results
            dispatchGroup.leave()
        }, failure: { error in
            print(error)
            dispatchGroup.leave()
        })
        
        // Call on main thread
        dispatchGroup.notify(qos: .userInitiated, queue: .main) { [weak self] in
            guard let flower = flower,
                let sightings = sightings
                else {
                    self?.presenter?.presentFlowerError(RemoteResourceError.invalidResponse)
                    return
            }
            
            self?.presenter?.presentFlower(flower, sightings: sightings)
        }
    }
}
