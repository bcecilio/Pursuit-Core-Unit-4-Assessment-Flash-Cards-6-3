//
//  CardAPIClient.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct CardAPIClient {
    static func getCards(completion: @escaping (Result<[Card], AppError>) -> ()) {
        let endpointURL = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let cards = try JSONDecoder().decode(CardData.self, from: data)
                    completion(.success(cards.cards))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

public enum AppleServiceError: Error {
    case resourcePathDoesNotExist
    case contentsNotFound
    case decodingError(Error)
}

struct CardLocalClient {
    static func getCardsLocal() throws -> [Card] {
        guard let path = Bundle.main.path(forResource: "CardJson", ofType: "json") else {
            throw AppleServiceError.resourcePathDoesNotExist
        }
        guard let json = FileManager.default.contents(atPath: path) else {
            throw AppleServiceError.contentsNotFound
        }
        do {
            let card = try JSONDecoder().decode([Card].self, from: json)
            return card
        } catch {
            throw AppleServiceError.decodingError(error)
        }
    }
}
