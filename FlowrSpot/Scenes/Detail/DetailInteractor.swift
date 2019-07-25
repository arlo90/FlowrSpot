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
}

// MARK: - Business Logic
extension DetailInteractor: DetailBusinessLogic {
    func fetchFlower(flowerId: Int) {
        getFlowersWorker.execute(flowerId: flowerId, success: { (flower) in
            self.presenter?.presentFlower(flower)
        }, failure: { error in
            self.presenter?.presentFlowerError(error)
        })
    }
}
