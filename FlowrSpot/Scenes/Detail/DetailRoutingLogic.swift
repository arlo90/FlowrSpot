//
//  DetailRoutingLogic.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit

protocol DetailRoutingLogic {
    func navigateToCreateNewSighting(flower: Flower)
    func navigateToSightingDetails(sighting: Sighting)
    func navigateToAlert(title: String, message: String, handler: (() -> Void)?)
}

protocol DetailRouterDelegate: class {
    
}

class DetailRouter {
    weak var viewController: FlowerDetailViewController?
    weak var delegate: DetailRouterDelegate?
}

// MARK: - Routing Logic
extension DetailRouter: DetailRoutingLogic {
    func navigateToCreateNewSighting(flower: Flower) {
        let newVC = CreateNewSightingViewController(flower: flower)
        // There is an issue, if background color is clear, transition is laggy, stops midway.
        newVC.view.backgroundColor = .white
        
        viewController?.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func navigateToSightingDetails(sighting: Sighting) {
        
    }
    
    func navigateToAlert(title: String, message: String, handler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "general_ok".localized(), style: .cancel, handler: { _ in handler?() }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
