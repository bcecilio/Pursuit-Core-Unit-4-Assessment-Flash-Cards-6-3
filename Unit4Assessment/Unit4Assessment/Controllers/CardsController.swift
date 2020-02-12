//
//  CardsController.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsController: UIViewController {
    
    private let initalView = CardsView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    public var savedCards = [Card]() {
        didSet {
            initalView.collectionView.reloadData()
            print("there are \(savedCards.count) articles")
            if savedCards.isEmpty {
                initalView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles. Start browsing by tapping on the News Icon.")
            } else {
                initalView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = initalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        loadSavedCards()
        initalView.collectionView.dataSource = self
        initalView.collectionView.delegate = self
        initalView.collectionView.register(InitialVCCardCell.self, forCellWithReuseIdentifier: "cardCell")
    }
    
    private func loadSavedCards() {
        do {
            savedCards = try dataPersistence.loadItems()
        } catch {
            print("could not load saved items: \(error)")
        }
    }
}

extension CardsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? InitialVCCardCell else {
            fatalError("could not downcast InitialVCCardCell")
        }
        let cardCell = savedCards[indexPath.row]
        cell.configureInitialCell(for: cardCell)
        cell.backgroundColor = .white
        cell.delegate2 = self
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

extension CardsController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadSavedCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadSavedCards()
    }
}

extension CardsController: CardCellDelegate {
    func didSelectMoreButton(_ savedCell: InitialVCCardCell, card: Card) {
        print("didSelectMoreButton: \(card.cardTitle)")
        // create an action sheet
        // cancel + delete action
        // post MVP
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
        guard let index = savedCards.firstIndex(of: card) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("error deleting article: \(error)")
        }
    }
}
