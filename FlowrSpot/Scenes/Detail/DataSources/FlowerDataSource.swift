//
//  FlowerDataSource.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import PovioKit

class FlowerDataSource: NSObject, DataSource {
    var sections = [FlowersSection]()
    private var flower: Flower?
    private var sightings: [Sighting]?
    
    func update(flower: Flower, sightings: [Sighting]) {
        self.flower = flower
        self.sightings = sightings
        buildSections()
    }
}

// MARK: - UICollectionView DataSource
extension FlowerDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = row(at: indexPath) else {
            Logger.error("No availible row in dataSource at \(indexPath)")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(FlowerCollectionViewCell.self, at: indexPath)
        switch row {
        case let .flower(entity):
            cell.setFlower(entity)
        }
        return cell
    }
}

// MARK: - Private Methods
private extension FlowerDataSource {
    func buildSections() {
        let rows = [flower.map(FlowersRow.flower)!]
        sections = [FlowersSection(rows: rows)]
    }
}
