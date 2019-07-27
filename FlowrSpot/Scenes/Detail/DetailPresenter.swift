//
//  DetailPresenter.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    func presentFlower(_ flower: Flower, sightings: [Sighting])
    func presentFlowerError(_ error: RemoteResourceError)
}

class DetailPresenter {
    weak var viewController: DetailDisplayLogic?
}

// MARK: - Presentation Logic
extension DetailPresenter: DetailPresentationLogic {
    func presentFlower(_ flower: Flower, sightings: [Sighting]) {
        viewController?.displayFlower(flower, sightings: sightings)
    }
    
    func presentFlowerError(_ error: RemoteResourceError) {
        viewController?.displayError(error)
    }
}
