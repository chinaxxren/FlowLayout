//
//  DecorationController.swift
//  Demo
//
//  Created by 赵江明 on 2020/9/2.
//  Copyright © 2020 赵江明. All rights reserved.
//

import UIKit
import DeepDiff

class DecorationController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var list = [Message]()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = FlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = UICollectionViewFlowLayout.automaticSize;
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize;

        
        let instance = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        instance.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        instance.backgroundColor = .white
        instance.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        instance.register(CollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        instance.register(BackgroundReusableView.self, forSupplementaryViewOfKind: BackgroundReusableView.elementKindBackground, withReuseIdentifier: BackgroundReusableView.elementKindBackground)
        instance.delegate = self
        instance.dataSource = self
        return instance
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(collectionView)

        
        navigationController?.setNavigationBarHidden(true, animated: false)

        for i in 1...4 {
            let comment = Message()
            comment.id = i
            comment.like = 10 + i
            list.append(comment)
        }
                
        self.collectionView.reloadData()
                
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return list.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
            cell.label.text = "\(String(describing: indexPath.row))"
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.label.text = "\(list[indexPath.row].like) -- \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row % 2 == 0 {
            for i in 0...15 {
                let comment = Message()
                comment.id = i
                comment.like = 20 + i
                list.insert(comment, at: indexPath.row + 1)
            }
        } else {
            list.removeAll { m in
                m.like > 22
            }
        }
        
        
        collectionView.reloadData()
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionReusableHeaderView
            view.backgroundColor = .blue
            view.label.text = "Header";
            return view;
        } else if kind == BackgroundReusableView.elementKindBackground {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BackgroundReusableView.elementKindBackground, for: indexPath)
            view.backgroundColor = .red

            return view
        }

        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .zero
    }
}


