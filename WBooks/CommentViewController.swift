//
//  CommentViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class CommentViewController: UIViewController {
    
    let bookDetailViewModel: BookDetailViewModel
    private let commentView: CommentView = CommentView.loadFromNib()!
    
    override func loadView() {
        view = commentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CommentCell.xibFileCommentCellName, bundle: nil)
        commentView.commentTable.register(nib, forCellReuseIdentifier: CommentCell.xibFileCommentCellName)
        commentView.commentTable.delegate = self
        commentView.commentTable.dataSource = self
        print(bookDetailViewModel.book)
    }
    
    init(usingViewModel: BookDetailViewModel) {
        self.bookDetailViewModel = usingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookDetailViewModel.comments.value.count
    }
    
    // Hard coded to fit all info. Should be replaced to dynamic height in function of components
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // Cell generator
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.xibFileCommentCellName) as? CommentCell else {
            return UITableViewCell()
        }
        
        cell.usernameLabel?.text = bookDetailViewModel.comments.value[indexPath.row].user.username
        cell.commentLabel?.text = bookDetailViewModel.comments.value[indexPath.row].content
        
        cell.userIcon?.image = UIImage()   // Add grey frame to make loading prettier
        
        if let url = URL(string: bookDetailViewModel.comments.value[indexPath.row].user.image) {
            cell.userIcon?.load(url: url)
        }
        
        return cell
    }
}
