//
//  SearchController.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchController: UIViewController {
    
    private let searchView = SearchCardsView()
    
    public let dataPersistence = DataPersistence<Card>(filename: "card.plist")
    
    private var searchCards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCardCell.self, forCellWithReuseIdentifier: "savedCell")
        getCards()
    }
    
    private func getCards() {
        CardAPIClient.getCards { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let card):
                self?.searchCards = card
            }
        }
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SearchCardCell else {
            fatalError("could not downcast SearchCardCell")
        }
        let savedCell = searchCards[indexPath.row]
        cell.configureCell(for: savedCell)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 1
        let itemHeight:CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1 ) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension SearchController: SearchSavedCellDelegate {
    func didSelectMoreButton(_ savedCell: SearchCardCell, card: Card) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
            self.deleteArticle(card)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteArticle(_ card: Card) {
        guard let index = searchCards.firstIndex(of: card) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("error deleting article: \(error)")
        }
    }
}
