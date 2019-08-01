//
//  CommentsViewDelegate.swift
//  OblastApp
//
//  Created by Jackie Norstrom on 7/31/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import Foundation

public protocol CommentsViewDelegate: class {
    func commentCellExpanded(atIndex index: Int)
    func commentCellFolded(atIndex index: Int)
}
