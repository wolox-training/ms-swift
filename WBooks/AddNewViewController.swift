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
  //  private let bookRepository: WBookRepositoryType
    
    override func loadView() {
        view = addNewView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "ADD_NEW_VIEW_NAVIGATION_TITLE".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        addNewView.addNewButton.addTapGestureRecognizer { _ in
            if self.allDataIsValid() {
                let addNewViewModel = AddNewViewModel(book: Book(status: "available",
                                                                 id: Int.random(in: 500...1000),
                                                                 author: self.addNewView.authorTextField.text!,
                                                                 title: self.addNewView.titleTextField.text!,
                                                                 image: "some_url",
                                                                 year: self.addNewView.yearTextField.text!,
                                                                 genre: self.addNewView.topicTextField.text!))
                addNewViewModel.printBook()
            } else {
                let alert = UIAlertController(title: "Error", message: "Data is not valid\nPlease check your entry", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    func setup() {
        addNewView.yearTextField.onlyAcceptsNumbers = true
        addNewView.bookCover.isUserInteractionEnabled = true
        setupImagePicker()
    }
    
    func allDataIsValid() -> Bool {
        return addNewView.authorTextField.isValidInput() && addNewView.titleTextField.isValidInput() && addNewView.yearTextField.isValidInput() && addNewView.topicTextField.isValidInput() && addNewView.descriptionTextField.isValidInput()
    }
}

extension AddNewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupImagePicker() {
        let alertController = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let galleryAction = UIAlertAction(title: "ADD_NEW_VIEW_GALLERY_ACTION".localized(), style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: .none)
        }
        alertController.addAction(galleryAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "ADD_NEW_VIEW_CAMERA_ACTION".localized(), style: .default) { _ in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: .none)
            }
            alertController.addAction(cameraAction)
        }
        
        let cancelAction = UIAlertAction(title: "ADD_NEW_VIEW_CANCEL_ACTION".localized(), style: .cancel, handler: .none)
        alertController.addAction(cancelAction)
        
        addNewView.bookCover.addTapGestureRecognizer { _ in
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addNewView.bookCover.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
