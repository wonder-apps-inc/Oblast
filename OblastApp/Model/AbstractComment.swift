//
//  AbstractComment.swift
//  OblastApp
//
//  Created by Jackie Norstrom on 7/31/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import Foundation

/// Defines the minimal properties a comment model must have (requiered by the CommentsViewController)
public protocol AbstractComment: class {
    var replies: [AbstractComment]! { get set }
    var level: Int! { get set }
    /*weak*/ var replyTo: AbstractComment? { get set }
}
