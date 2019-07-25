//
//  FlowersDataSource.swift
//  FlowrSpot
//
//  Created by TK on 18/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import PovioKit

class FlowersDataSource: NSObject, DataSource {
  var sections = [FlowersSection]()
  private var flowers = [Flower]()
  
  func update(flowers: [Flower]) {
    self.flowers = flowers
    buildSections()
  }
}

// MARK: - UICollectionView DataSource
extension FlowersDataSource: UICollectionViewDataSource {
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
private extension FlowersDataSource {
  func buildSections() {
    let rows = flowers.map(FlowersRow.flower)
    sections = [FlowersSection(rows: rows)]
  }
}
