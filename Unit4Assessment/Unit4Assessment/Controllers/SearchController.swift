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
    
    private var savedCard = [Card]()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCardCell.self, forCellWithReuseIdentifier: "savedCell")
    }
    
    private func getCards() {
        CardAPIClient.getCards { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let cards):
                self?.savedCard = cards
            }
        }
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SearchCardCell else {
            fatalError("could not downcast SearchCardCell")
        }
        let savedCell = savedCard[indexPath.row]
        cell.configureCell(for: savedCell)
        return cell
    }
}
