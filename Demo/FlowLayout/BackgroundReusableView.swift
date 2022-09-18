//
//  BackgroundReusableView.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/14.
//  Copyright © 2022 赵江明. All rights reserved.
//

import UIKit

class BackgroundReusableView: UICollectionReusableView {
    
    /// Used for all supplementaryView's representing a section background
    static let elementKindBackground = "FlowLayoutBackgroundView"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 18
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        layer.masksToBounds = true
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 18, height: 18))
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowPath = path.cgPath
        layer.masksToBounds = false
    }
}
