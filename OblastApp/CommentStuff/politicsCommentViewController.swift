//
//  politicsCommentView.swift
//  OblastApp
//
//  Created by Jackie Norstrom on 8/4/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit
import SwiftyComments


class politicsCommentViewController: CommentsViewController {
    
    private let commentCellId = "simpleCommentCellId"
    var allComments: [RichComment] = [] // All the comments (nested, not in a linear format)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(politicsCommentCell.self, forCellReuseIdentifier: commentCellId)
        
        allComments = RandomDiscussion.generate().comments
        //currentlyDisplayed = allComments
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CommentCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: commentCellId, for: indexPath) as! politicsCommentCell
        let comment = currentlyDisplayed[indexPath.row] as! RichComment
        commentCell.level = comment.level
        commentCell.commentContent = comment.body
        commentCell.posterName = comment.posterName
        return commentCell
    }
    
}
