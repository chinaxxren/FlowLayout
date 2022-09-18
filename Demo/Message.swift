//
//  Message.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/14.
//  Copyright © 2022 赵江明. All rights reserved.
//

import Foundation
import DeepDiff
import IGListKit

class Message:NSObject, Codable,DiffAware,ListDiffable {
    var id: Int = 0
    var like: Int = 0
    
    static func ==(lhs: Message, rhs: Message) -> Bool {
       if lhs.id != rhs.id {
           return false
       }
       if lhs.like != rhs.like {
           return false
       }
       return true
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
      return "\(id)" as NSObjectProtocol
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
      return isEqual(object)
    }
}
