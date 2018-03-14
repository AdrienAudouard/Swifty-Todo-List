//
//  ListCollectionView.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class ListCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var lists: [List] = [List]() {
        didSet {
            selectedCell = [Bool](repeating: false, count: lists.count)
            self.reloadData()
        }
    }
    
    var selectedCell: [Bool] = [Bool]()
    var selectedList: List?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.dataSource = self        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
        
        item.list = lists[indexPath.row + 1]
        item.isSelect = selectedCell[indexPath.row + 1]
        return item
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 40 + lists[indexPath.row + 1].name.count * 8
        return CGSize(width: width, height: 40);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for indexP in collectionView.indexPathsForVisibleItems {
            let cell = collectionView.cellForItem(at: indexP) as! ListCollectionViewCell
            
            cell.isSelect = indexPath == indexP
            selectedCell[indexPath.row + 1] = cell.isSelect
        }
        
        selectedList = lists[indexPath.row + 1]
    }
    
    
    /*
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 30);
    }*/

}
