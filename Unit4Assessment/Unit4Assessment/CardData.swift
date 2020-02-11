//
//  CardData.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct CardData: Codable, Equatable {
    let cards: [Card]
}

struct Card: Codable, Equatable {
    let id, cardTitle: String
    let facts: [String]
}
