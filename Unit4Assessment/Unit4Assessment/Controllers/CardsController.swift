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
    }
    
    private func loadSavedCards() {
        do {
            savedCards = try dataPersistence.loadItems()
        } catch {
            print("could not load saved items: \(error)")
        }
    }
}
