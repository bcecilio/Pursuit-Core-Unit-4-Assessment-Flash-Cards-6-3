//
//  TabBarControllerViewController.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {
    
    lazy private var cardController: CardsController = {
        let VC = CardsController()
        VC.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "quote.bubble"), tag: 0)
        return VC
    }()
    
    lazy private var createCardController: CreateCardController = {
        let VC = CreateCardController()
        VC.tabBarItem = UITabBarItem(title: "Create Cards", image: UIImage(systemName: "pencil.and.ellipsis.rectangle"), tag: 1)
        return VC
    }()
    
   lazy private var searchCardController: SearchController = {
        let VC = SearchController()
        VC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return VC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [cardController, createCardController, searchCardController]
    }
}
