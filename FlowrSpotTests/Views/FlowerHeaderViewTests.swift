//
//  FlowerHeaderViewTests.swift
//  FlowrSpotTests
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import XCTest
@testable import FlowrSpot

class FlowersHeaderViewTests: XCTestCase {
    
    let flower = Flower(id: 1, name: "Lily", latinName: "Lily lily", sightings: 10, profilePicture: "", favorite: false, description: "Lily flower")
    
    func loadViewTest() {
        let headerView: FlowerHeaderView = FlowerHeaderView.loadView()
        
        headerView.setup(flower: flower, router: nil)
        
        XCTAssert(headerView.titleLabel.text == flower.name, "Wrong name")
        XCTAssert(headerView.subtitleLabel.text == flower.latinName, "Wrong latin name")
        XCTAssert(headerView.sightingLabel.text == "sightings_count".localized(flower.sightings ?? 0), "Wrong sighting")
        XCTAssert(headerView.descriptionLabel.text == flower.description, "Wrong description")
    }
}
