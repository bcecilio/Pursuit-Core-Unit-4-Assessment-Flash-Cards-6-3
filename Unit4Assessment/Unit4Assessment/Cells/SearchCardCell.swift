//
//  SearchCardCell.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol SearchSavedCellDelegate: AnyObject {
    func didSelectMoreButton(_ searchCell: SearchCardCell, card: Card)
}

class SearchCardCell: UICollectionViewCell {
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "QUESTION QUESTINO QUESTION QUESITON"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var description1: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var description2: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    private var descriptionShowing = false
    
    weak var delegate: SearchSavedCellDelegate?
    
    public var selectedCard: Card!
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addGestureRecognizer(longPressGesture)
        setupButton()
        setupTitle()
        setupDescription1()
        setupDescription2()
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, card: selectedCard)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let currentCard = selectedCard else {return}
        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
        descriptionShowing.toggle()
    }
    
    private func animate() {
        let duration: Double = 0.8
        if descriptionShowing {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 1.0
                self.description1.alpha = 0.0
                self.description2.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 0.0
                self.description1.alpha = 1.0
                self.description2.alpha = 1.0
            }, completion: nil)
        }
    }
    
    private func setupButton() {
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor)
        ])
    }
    
    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupDescription1() {
        addSubview(description1)
        description1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description1.topAnchor.constraint(equalTo: saveButton.bottomAnchor),
            description1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            description1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            description1.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupDescription2() {
        addSubview(description2)
        description2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description2.topAnchor.constraint(equalTo: description1.bottomAnchor, constant: 20),
            description2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            description2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            description2.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureCell(for searchCard: Card) {
        titleLabel.text = searchCard.cardTitle
//        description1.text = savedCard.facts.first
//        description2.text = savedCard.facts.last
    }
}
