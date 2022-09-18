//
//  ViewController.swift
//  Demo
//
//  Created by 赵江明 on 2020/9/2.
//  Copyright © 2020 赵江明. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class CollectionController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var list = Array<Int>()
    
    lazy var collectionView: UICollectionView = {
        let layout = JJCollectionViewRoundFlowLayout_Swift();
        //setting
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = UICollectionViewFlowLayout.automaticSize;
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize;

        
        let instance = UICollectionView(frame: .zero, collectionViewLayout: layout)
        instance.backgroundColor = .white
        instance.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
//        instance.register(CollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
//        instance.register(CollectionReusableFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionReusableView")
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
        
        for i in 1...200 {
            list.append(i)
        }
        
        collectionView.reloadData()
        
        
                
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 2
//        }
        return list.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
            cell.label.text = "\(String(describing: list[indexPath.row]))"
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.label.text = "\(String(describing: list[indexPath.row]))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldList = list
        
        for i in 10...20 {
            list.remove(at: i)
        }
        self.collectionView.reloadData()
//        collectionView.applyDiff(oldList, list, inSection: 1, completion: { _ in
//
//        })
    }
    
    func deleteItems() {
        collectionView.performBatchUpdates {
            var indexs = [IndexPath]()
            for i in 10...11 {
                let index = IndexPath(row: i, section: 1)
                indexs.append(index)
                list.remove(at: i)
            }
            
            collectionView.deleteItems(at: indexs)
        }
    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
//        if kind == UICollectionView.elementKindSectionHeader {
//            view.label.text = "Header";
//            return view;
//        }else{
//            view.label.text = "Footer";
//            return view;
//        }
//    }
}

extension CollectionController: JJCollectionViewDelegateRoundFlowLayout_Swift {
    
//    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, isCalculateHeaderViewIndex section: NSInteger) -> Bool {
//        return section == 1
//    }
//
//    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, isCalculateFooterViewIndex section: NSInteger) -> Bool {
//        return false
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
        let model = JJCollectionViewRoundConfigModel_Swift.init();
        model.borderWidth = 2
        model.borderColor = UIColor.black
        model.shadowColor = UIColor.black
        model.shadowOffset = CGSize(width: 2, height: 2)
        model.shadowOpacity = 1
        model.shadowRadius = 0
        
        
        if #available(iOS 13.0, *) {
            model.backgroundColor = UIColor.init { (traitCollection:UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0);
            }
        } else {
            // Fallback on earlier versions
            model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
        }
        
        model.cornerRadius = 10;
        model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0);
        
        return model;
        
    }
}

