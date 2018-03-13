//
//  SelectListCollectionView.swift
//  TodoList
//
//  Created by Adrien Audouard on 12/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class SelectListCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var lists: [List] = [List]() {
        didSet {
            selectedCell = [Bool](repeating: false, count: lists.count)
            selectedList.removeAll()
            self.reloadData()
        }
    }
    
    var selectedCell: [Bool] = [Bool]()
    var selectedList: [List] = [List]()
    
    weak var listDelegate: FilterListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectListCollectionViewCell", for: indexPath) as! SelectListCollectionViewCell
        
        
        item.list = lists[indexPath.row]
        item.isSelect = selectedCell[indexPath.row]
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 120
        return CGSize(width: width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectListCollectionViewCell
        if cell.isSelect {
            selectedList.remove(at: selectedList.index(of: lists[indexPath.row])!)
            listDelegate?.removeFilter(list: lists[indexPath.row])
        } else {
            selectedList.append(lists[indexPath.row])
            listDelegate?.addFilter(list: lists[indexPath.row])
        }
        
        cell.isSelect = !cell.isSelect
        
        selectedCell[indexPath.row] = cell.isSelect
    }
}
