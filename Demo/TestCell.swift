//
//  TestCell.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/24.
//  Copyright © 2022 赵江明. All rights reserved.
//


import UIKit

class TestCell: UICollectionViewCell {

    lazy var label: UILabel = {
       let instance = UILabel()
        instance.textAlignment = .center
        instance.textColor = .black
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
    }
    
    func fillData(text: String) {
        label.text = text
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .green
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = ceil(size.width)
        newFrame.size.height = 40
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}


