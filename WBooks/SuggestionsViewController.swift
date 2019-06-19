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
    private let suggestionsViewModel: SuggestionsViewModel = SuggestionsViewModel()
    
    override func loadView() {
        view = suggestionsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        suggestionsViewModel.updateRepository()
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
        
        setupBindings()
    }
}

extension SuggestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionsViewModel.suggestedBooks.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.xibFileSuggestionCollectionViewCell, for: indexPath) as? SuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let book: Book = suggestionsViewModel.suggestedBooks.value[indexPath.row]
        
        cell.bookCover.image = UIImage()
        if let url = book.imageUrl {
            cell.bookCover?.load(url: url)
        }
        
        return cell
    }
}

extension SuggestionsViewController {
    func setupBindings() {
        suggestionsViewModel.suggestedBooks.producer.startWithValues { [unowned self] _ in
            self.suggestionsView.collectionView.reloadData()
        }
    }
}
