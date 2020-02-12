//
//  InitialVCCardCell.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol MainVCCellDelegate: AnyObject {
    func didSelectMoreButton(_ searchCell: InitialVCCardCell, card: Card)
}

class InitialVCCardCell: UICollectionViewCell {

    public var selectedCard2: Card!
    
    private var descriptionShowing = false
    
    weak var delegate: MainVCCellDelegate?
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
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
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupButton()
        setupTitle()
        setupDescription1()
        setupDescription2()
    }
    
     @objc private func buttonPressed(_ sender: UIButton) {
           delegate?.didSelectMoreButton(self, card: selectedCard2)
       }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let currentCard = selectedCard2 else {return}
        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
        descriptionShowing.toggle()
        description1.text = selectedCard2.facts.description
        animate()
    }
    
    private func animate() {
        let duration: Double = 0.5
        if descriptionShowing {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 0.0
                self.description1.alpha = 1.0
                self.description2.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 1.0
                self.description1.alpha = 0.0
                self.description2.alpha = 0.0
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
    
    public func configureInitialCell(for cardData: Card) {
        titleLabel.text = cardData.cardTitle
    }
}
