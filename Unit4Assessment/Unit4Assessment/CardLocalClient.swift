//
//  CardLocalClient.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
public enum ServiceError: Error {
 case resourcePathDoesNotExist
 case contentsNotFound
 case decodingError(Error)
}
class JSONData {
 public static func getCardsLocally() throws -> [Card] {
  guard let path = Bundle.main.path(forResource: "card", ofType: "json") else {
   throw ServiceError.resourcePathDoesNotExist
  }
  guard let json = FileManager.default.contents(atPath: path) else {
   throw ServiceError.contentsNotFound
  }
  do {
   let cards = try JSONDecoder().decode([Card].self, from: json)
    return cards
  } catch {
   throw ServiceError.decodingError(error)
  }
 }
}
