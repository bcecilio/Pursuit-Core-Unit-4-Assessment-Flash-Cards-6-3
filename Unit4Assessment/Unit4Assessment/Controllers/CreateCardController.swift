//
//  CreateCardController.swift
//  Unit4Assessment
//
//  Created by Brendon Cecilio on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardController: UIViewController {
    
    private let createCardView = CreateCardsView()
    
    private var textPersistence = DataPersistence<Card>(filename: "card.plist")
    
    private var originalConstraint: [NSLayoutConstraint]!
    
    private var keyboardIsVisible = false
    
    public var createdCard: Card?
    
    override func loadView() {
        view = createCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        createCardView.titleTextField.delegate = self
        createCardView.description2Field.delegate = self
        createCardView.description1Field.delegate = self
        registerForKeyboardNotifications()
        createCardButtonTarget()
    }
    
    private func createCardButtonTarget() {
        createCardView.createButton.addTarget(self, action: #selector(createCard), for: .touchUpInside)
    }

    @objc private func createCard() {
        if createCardView.titleTextField.text!.isEmpty && ((createCardView.description1Field.text?.isEmpty) != nil) && ((createCardView.description2Field.text?.isEmpty) != nil) {
            showAlert(title: "Text boxes are empty!", message: "Cards must have a Title and two Descriptions.")
        } else {
            createdCard = Card(id: "2", cardTitle: createCardView.titleTextField.text!, facts: [createCardView.description1Field.text!,createCardView.description2Field.text!])
            createNewCard(card: createdCard!)
        }
    }
    
    public func createNewCard(card: Card) {
        let savedCardsVC = CardsController()
        savedCardsVC.savedCards.append(card)
        try? textPersistence.createItem(card)
        showAlert(title: "Success!", message: "Your Flash Card was successfully created.")
        createCardView.titleTextField.text = ""
        createCardView.description1Field.text = ""
        createCardView.description2Field.text = ""
    }
    
    public func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension CreateCardController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {

            createCardView.description1Field.text = "Enter Description 1"
            createCardView.description2Field.text = "Enter Description 2"
            createCardView.titleTextField.text = "Enter Question"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        else {
            return true
        }
        return false
    }
}


