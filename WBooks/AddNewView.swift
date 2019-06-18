//
//  AddNewView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class AddNewView: UIView, NibLoadable {
    
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var titleTextField: WTextField!
    @IBOutlet weak var authorTextField: WTextField!
    @IBOutlet weak var yearTextField: WTextField!
    @IBOutlet weak var topicTextField: WTextField!
    @IBOutlet weak var descriptionTextField: WTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

private extension AddNewView {
    func setupView() {
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        childView.layer.cornerRadius = 22
    }
}
