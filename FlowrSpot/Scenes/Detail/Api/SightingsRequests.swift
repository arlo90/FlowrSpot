//
//  SightingsRequests.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import Alamofire

enum SightingsRequests: Request {
    case sightingsList(id: Int)
    
    var path: String {
        switch self {
        case let .sightingsList(id):
            return "flowers/\(String(id))/sightings"
        }
    }
}
