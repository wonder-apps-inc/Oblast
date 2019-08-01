//
//  CommentViewController.swift
//  OblastApp
//
//  Created by Jackie Norstrom on 7/31/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit
import SwiftyComments



class CommentViewController: CommentsViewController {
    private let commentCellId = "commentCellId"
    
    var allComments: [CommentView] = [] // All the comments (nested, not in a linear format)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CommentCell.self, forCellReuseIdentifier: commentCellId)
        currentlyDisplayed = allComments as! [AbstractComment] // Assuming your models are loaded in allComments
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CommentCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: commentCellId, for: indexPath) as! CommentCell
        let comment = currentlyDisplayed[indexPath.row] as! RichComment
        ;        commentCell.level = comment.level
        // commentCell.body = ...
        return commentCell
    }
}


