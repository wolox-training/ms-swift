//
//  AddNewViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class AddNewViewController: UIViewController {
    
    private let addNewView: AddNewView = AddNewView.loadFromNib()!
    
    override func loadView() {
        view = addNewView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "ADD_NEW_VIEW_NAVIGATION_TITLE".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        let alertController = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: .none)
        }
        alertController.addAction(galleryAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: .none)
            }
            alertController.addAction(cameraAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: .none)
        alertController.addAction(cancelAction)
        
        addNewView.bookCover.addTapGestureRecognizer { _ in
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setup() {
        addNewView.yearTextField.onlyAcceptsNumbers = true
        addNewView.bookCover.isUserInteractionEnabled = true

    }
    
}

extension AddNewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addNewView.bookCover.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
