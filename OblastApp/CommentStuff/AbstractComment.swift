//
//  AbstractCommetn.swift
//  OblastApp
//
//  Created by Jackie Norstrom on 8/4/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import Foundation


public protocol AbstractComment: class {
    var replies: [AbstractComment]! { get set }
    var level: Int! { get set }
    var replyTo: AbstractComment? { get set }
}
