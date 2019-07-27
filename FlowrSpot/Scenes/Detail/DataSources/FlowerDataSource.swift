//
//  FlowerDataSource.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import PovioKit

class FlowerDataSource: NSObject, DataSource {
    var sections = [SightingsSection]()
    private var sightings = [Sighting]()
    
    func update(sightings: [Sighting]) {
        self.sightings = sightings
        buildSections()
    }
}

// MARK: - UITableView DataSource
extension FlowerDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = row(at: indexPath) else {
            Logger.error("No availible row in dataSource at \(indexPath)")
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SightingTableViewCell.identifier, for: indexPath)
        switch row {
        case let .sighting(entity):
            (cell as? SightingTableViewCell)?.setup(sighting: entity)
        }
        return cell
    }
}

// MARK: - Private Methods
private extension FlowerDataSource {
    func buildSections() {
        let rows = sightings.map(SightingsRow.sighting)
        sections = [SightingsSection(rows: rows)]
    }
}
