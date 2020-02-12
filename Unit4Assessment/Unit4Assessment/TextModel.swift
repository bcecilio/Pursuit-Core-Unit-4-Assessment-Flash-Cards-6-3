//
//  TextModel.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/12/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct TextObject: Codable {
    let title: String
    let descrition1: String
    let description2: String
    let identifier = UUID().uuidString
}
