//
//  MessageSectionController.swift
//  Demo
//
//  Created by 赵江明 on 2022/8/16.
//  Copyright © 2022 赵江明. All rights reserved.
//


import UIKit
import IGListKit

class MessageSectionController: ListSectionController {

    var sessionDto: SessionDto!
    
    typealias TapMessage =  (Int) -> Void
    var tapMessage: TapMessage?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        supplementaryViewSource = self
    }
}

// MARK: Data Provider
extension MessageSectionController {
    
    // MARK: IGListSectionController Overrides
    override func numberOfItems() -> Int {
        return sessionDto.list.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        guard let context = collectionContext else {
            return .zero
        }
        
        let width = context.containerSize.width
        
        return CGSize(width: UIScreen.main.bounds.width - inset.left - inset.right, height: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = collectionContext!.dequeueReusableCell(of: MessageCell.self,for: self,at: index)
        if let cell = cell as? MessageCell {
            let message = sessionDto.list[index]
            cell.fillData(text: "\(message.id)")
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        sessionDto = object as? SessionDto
    }
    
    override func didSelectItem(at index: Int) {
        
//        for i in 10...20 {
//            let message = sessionDto.list[i]
//            print(message.id)
//            sessionDto.list.remove(at: i)
//        }
//
//        tapMessage?(index)
        print("aaaa")
    }
}

extension MessageSectionController: ListSupplementaryViewSource {
    
    func supportedElementKinds() -> [String] {
        [UICollectionView.elementKindSectionHeader,BackgroundReusableView.elementKindBackground]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        if elementKind == UICollectionView.elementKindSectionHeader {
            let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: CollectionReusableHeaderView.self, at: index) as! CollectionReusableHeaderView
            view.label.text = "Header";
            return view;
        }  else if elementKind == BackgroundReusableView.elementKindBackground {
            let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: BackgroundReusableView.elementKindBackground,
                                                                for: self, class: BackgroundReusableView.self, at: index) as! BackgroundReusableView
            view.backgroundColor = .red
            return view
        }

        return UICollectionReusableView()
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - inset.left - inset.right, height: 40)
    }
    
}
