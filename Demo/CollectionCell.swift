//
//  CollectionCell.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/12.
//  Copyright © 2022 赵江明. All rights reserved.
//


import UIKit

class CollectionCell: UICollectionViewCell {

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .green
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
    }
}
