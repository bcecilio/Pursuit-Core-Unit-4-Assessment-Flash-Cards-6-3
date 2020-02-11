//
//  CreateCardsView.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardsView: UIView {
    
    public lazy var stackView: UIStackView = {
        let SV = UIStackView()
        SV.addArrangedSubview(titleTextField)
        SV.addArrangedSubview(description1Field)
        SV.addArrangedSubview(description2Field)
        SV.addArrangedSubview(createButton)
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
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 250),
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
            createButton.widthAnchor.constraint(equalToConstant: 80)
        ])
}
}
