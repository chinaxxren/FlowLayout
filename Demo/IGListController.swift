//
//  ViewController.swift
//  Demo
//
//  Created by 赵江明 on 2020/9/2.
//  Copyright © 2020 赵江明. All rights reserved.
//

import UIKit
import IGListKit

class IGListController: UIViewController {

    let sessionDto = SessionDto()
    let testDto = TestDto()
    let moreDto = SessionDto()
    
    lazy var collectionView: UICollectionView = {
        let layout = FlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let instance = UICollectionView(frame: .zero, collectionViewLayout: layout)
        instance.backgroundColor = .white
        return instance
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(),
                           viewController: self,
                           workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        view.addSubview(collectionView)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        adapter.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }

}


// MARK: - ListAdapterDataSource
extension IGListController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
         return [sessionDto,testDto,moreDto]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is SessionDto {
            let sc = MessageSectionController()
            sc.tapMessage = { index in
                self.adapter.reloadData()
            }
            return sc
        } else {
            let sc = TestSectionController()
            sc.tapMessage = { index in
                self.adapter.reloadData()
            }
            return sc
        }
        
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
