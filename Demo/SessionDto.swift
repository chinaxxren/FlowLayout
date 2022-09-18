//
//  SessionDto.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/16.
//  Copyright © 2022 赵江明. All rights reserved.
//

import Foundation
import IGListKit

public class SessionDto: NSObject,ListDiffable {
    
    var list = [Message]()
    
    override init() {
        for i in 1...10 {
            let message = Message()
            message.id = i
            message.like = 20 + i
            list.append(message)
        }
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
