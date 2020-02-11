//
//  SearchController.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    private let searchView = SearchCardsView()
    
    private var cardData = [Card]()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    
    private func getCards() {
        CardAPIClient.getCards { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let cards):
                self?.cardData = cards
            }
        }
    }
}
