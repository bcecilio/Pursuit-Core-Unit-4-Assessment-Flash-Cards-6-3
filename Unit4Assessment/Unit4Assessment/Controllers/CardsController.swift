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
    
    public var savedPersistence = DataPersistence<Card>(filename: "card.plist")
    //public var dataPersistence: DataPersistence<Card>!
    
    public var savedCards = [Card]() {
        didSet {
            appendToCollectionView()
            initalView.collectionView.reloadData()
            print("there are \(savedCards.count) cards")
            if savedCards.isEmpty {
                initalView.collectionView.backgroundView = EmptyView(title: "Saved Cards", message: "There are currently no saved Cards. Start browsing or Create a new Card!")
            } else {
                initalView.collectionView.backgroundView = nil
            }
        }
    }
    
    public var selectedImageInitial: Card? {
        didSet {
            appendToCollectionView()
        }
    }
    
    override func loadView() {
        view = initalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        initalView.collectionView.dataSource = self
        initalView.collectionView.delegate = self
        initalView.collectionView.register(InitialVCCardCell.self, forCellWithReuseIdentifier: "cardCell")
        loadSavedCards()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         loadSavedCards()
    }
    
    private func loadSavedCards() {
        do {
            savedCards = try savedPersistence.loadItems()
        } catch {
            print("could not load saved items: \(error)")
        }
    }
    
    private func appendToCollectionView() {
        guard let initialCard = selectedImageInitial else {
            print("no card found initialVC")
            return
        }
        do {
            try savedPersistence.createItem(initialCard)
        } catch {
            print("saving error: \(error)")
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
        cell.selectedCard2 = savedCards[indexPath.row]
        cell.backgroundColor = .white
        cell.delegate = self
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

extension CardsController: MainVCCellDelegate {
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
            try savedPersistence.deleteItem(at: index)
        } catch {
            print("error deleting article: \(error)")
        }
    }
}
