//
//  WTextField.swift
//  WBooks
//
//  Created by Matías David Schwalb on 14/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

@IBDesignable
open class WTextField: UITextField, UITextFieldDelegate {

    public var onlyAcceptsNumbers = false
    // When using WTextField, user must set this property to true beforehand if the textfield only accepts numbers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField() {
        delegate = self
        borderStyle = UITextField.BorderStyle(rawValue: 0)!
        attributedPlaceholder = NSAttributedString(string: "", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.italicSystemFont(ofSize: 14.0)])
        setPadding()
        setBottomLine(state: .sleeping)
        
        reactive.continuousTextValues.signal.observeValues { textOnField in
            self.updateTextFieldState(textOnField: textOnField!)
        }
    }
    
    func updateTextFieldState(textOnField: String) {
        let currentState: TextFieldState
        if self.isEditing {
            if !isValidInput(textOnField: textOnField) {
                currentState = .incorrect
            } else {
                currentState = .editing
            }
        } else {
        currentState = .sleeping
        }
        
        setBottomLine(state: currentState)
    }
    
    func isValidInput(textOnField: String) -> Bool {
        /*
        if textOnField.contains("&") {
            return false
        } else {
            return true
        }
         */
        var returnValue = true
        if onlyAcceptsNumbers {
            if textOnField.containsALetter(input: textOnField) {
                returnValue = false
            }
        }
            return returnValue
    }
    
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: self.frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setBottomLine(state: TextFieldState) {
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        
        switch state {
        case .sleeping:
            layer.shadowColor = UIColor.lightGray.cgColor
        case .editing:
            layer.shadowColor = UIColor.gray.cgColor
        case .incorrect:
            layer.shadowColor = UIColor.red.cgColor
        }
    }
    
    enum TextFieldState {
        case sleeping
        case editing
        case incorrect
    }
}

extension String {
    
    func containsALetter(input: String) -> Bool {
        for forIndex in 0..<input.count {
            let stringIndex = input.index(input.startIndex, offsetBy: forIndex)
            if isAlpha(char: input[stringIndex]) {
                return true
            }
        }
        return false
    }
    
    func isAlpha(char: Character) -> Bool {
        switch char {
        case "a"..."z":
            return true
        case "A"..."Z":
            return true
        default:
            return false
        }
    }
}
