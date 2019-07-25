//
//  Sightings.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

struct Sighting: Codable {
    let id: Int
    let name: String
    let latinName: String
    let sightings: Int
    let picture: String
    let likesCount: Int
    let commentsCount: Int
    let description: String
    let user: User
    let flower: Flower
}
