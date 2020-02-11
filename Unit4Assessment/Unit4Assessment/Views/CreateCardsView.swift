//
//  CreateCardsView.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardsView: UIView {

    private lazy var titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Question"
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var description1Field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Description 1"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var description2Field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Description 2"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        return button
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
        setupQuestionField()
        setupDescription1()
        setupDescription2()
        setupCreateButton()
    }
    
    private func setupQuestionField() {
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 210),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDescription1() {
        addSubview(description1Field)
        description1Field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description1Field.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            description1Field.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            description1Field.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            description1Field.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupDescription2() {
        addSubview(description2Field)
        description2Field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description2Field.topAnchor.constraint(equalTo: description1Field.bottomAnchor, constant: 10),
            description2Field.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            description2Field.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            description2Field.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupCreateButton() {
        addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: description2Field.bottomAnchor, constant: 30),
            createButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 150),
            createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150)
        ])
    }
}
