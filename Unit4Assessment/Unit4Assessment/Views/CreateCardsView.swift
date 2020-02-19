//
//  CreateCardsView.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardsView: UIView {
    
    public lazy var stackView: UIStackView = {
        let SV = UIStackView()
        SV.addArrangedSubview(titleTextField)
        SV.addArrangedSubview(description1Field)
        SV.addArrangedSubview(description2Field)
        SV.addArrangedSubview(createButton)
        SV.addArrangedSubview(cancelButton)
        SV.alignment = .center
        SV.axis = .vertical
        SV.distribution = .equalSpacing
        SV.spacing = 20
        return SV
    }()
    
    public lazy var titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Question"
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        return field
    }()
    
    public lazy var description1Field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Description"
        field.borderStyle = .roundedRect
        return field
    }()
    
    public lazy var description2Field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Description"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Card", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(createCard), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(cancelCreateCard), for: .touchUpInside)
        return button
    }()
    
    public var createdCard2: TextObject?
    
    
    public var textPersistence = DataPersistence<Card>(filename: "card.plist")
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupQuestionField()
        setupDescription1()
        setupDescription2()
        setupCreateButton()
        setupCancelButton()
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func setupQuestionField() {
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.widthAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    private func setupDescription1() {
        addSubview(description1Field)
        description1Field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description1Field.widthAnchor.constraint(equalToConstant: 450),
            description1Field.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupDescription2() {
        addSubview(description2Field)
        description2Field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description2Field.widthAnchor.constraint(equalToConstant: 450),
            description2Field.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    //
    private func setupCreateButton() {
        addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCancelButton() {
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    public func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func createCard() {
        if titleTextField.text!.isEmpty || description1Field.text!.isEmpty || description2Field.text!.isEmpty {
            showAlert(title: "Text boxes are empty!", message: "Cards must have a Title and two Descriptions.")
        } else {
            let newCard = Card(id: "2", cardTitle: titleTextField.text!, facts: [description1Field.text!, description2Field.text!])
            do {
                try? textPersistence.createItem(newCard)
            } catch {
                print("could not create card: \(error)")
            }
        }
    }
    
    @objc private func cancelCreateCard() {
        if titleTextField.text!.isEmpty == false || description1Field.text!.isEmpty == false || description2Field.text!.isEmpty == false {
            titleTextField.text = ""
            description1Field.text = ""
            description2Field.text = ""
        }
    }
}
