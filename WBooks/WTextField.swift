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
        setPadding()
        setBottomLine(state: .sleeping)
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
        case .correct:
            layer.shadowColor = UIColor.green.cgColor
        case .incorrect:
            layer.shadowColor = UIColor.red.cgColor
        }
    }
    
    enum TextFieldState {
        case sleeping
        case editing
        case correct
        case incorrect
    }
}
