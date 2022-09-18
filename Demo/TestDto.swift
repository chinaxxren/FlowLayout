//
//  TestDto.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/19.
//  Copyright © 2022 赵江明. All rights reserved.
//


import Foundation
import IGListKit

public class TestDto: NSObject,ListDiffable {
    var id: Int = 100
    var list = [Message]()
    
    override init() {
        for i in 4...4 {
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
