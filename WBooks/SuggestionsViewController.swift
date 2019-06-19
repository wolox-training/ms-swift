//
//  SuggestionsViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 18/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController {

    private let suggestionsView: SuggestionsView = SuggestionsView.loadFromNib()!
    
    override func loadView() {
        view = suggestionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let nib = UINib(nibName: CommentCell.xibFileCommentCellName, bundle: nil)
        commentView.commentTable.register(nib, forCellReuseIdentifier: CommentCell.xibFileCommentCellName)
        */
        let nib = UINib(nibName: SuggestionCollectionViewCell.xibFileSuggestionCollectionViewCell, bundle: nil)
        //suggestionsView.collectionView.register(nib, forCellReuseIdentifier: SuggestionCollectionViewCell.xibFileSuggestionCollectionViewCell)
        suggestionsView.collectionView.register(nib, forCellWithReuseIdentifier: SuggestionCollectionViewCell.xibFileSuggestionCollectionViewCell)
        suggestionsView.collectionView.delegate = self
        suggestionsView.collectionView.dataSource = self
    }
}

extension SuggestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5    // Hard coded
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.xibFileSuggestionCollectionViewCell, for: indexPath) as? SuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bookCover.image = UIImage(named: "img_book2")
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
  
}
