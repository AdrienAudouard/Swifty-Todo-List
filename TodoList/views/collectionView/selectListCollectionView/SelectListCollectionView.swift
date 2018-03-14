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
            self.reloadData()
        }
    }
    
    var selectedCell: [Bool] = [Bool]()
    
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
    
    
    func deselectAllCellExceptFirst() {
        for indexP in self.indexPathsForVisibleItems {
            if indexP.row == 0 {
                continue
            }
            
            let cell = self.cellForItem(at: indexP) as! SelectListCollectionViewCell
            
            cell.isSelect = false
        }
        
        selectedCell = [Bool].init(repeating: false, count: selectedCell.count)
    }
    
    func deslectFirstCell () {
        guard let firstCell = self.cellForItem(at: IndexPath.init(row: 0, section: 0)) as? SelectListCollectionViewCell else {
            return
        }
        
        if firstCell.isSelect {
            listDelegate?.removeAll()
        }
        
        firstCell.isSelect = false
        selectedCell[0] = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectListCollectionViewCell
        
        if indexPath.row == 0 {
            deselectAllCellExceptFirst()
            if !cell.isSelect {
                print("select all")
                listDelegate?.printAllTask()
            } else {
                listDelegate?.removeAll()
            }
            cell.isSelect = !cell.isSelect
            selectedCell[0] = cell.isSelect
        } else {
            deslectFirstCell()
            if cell.isSelect {
                listDelegate?.removeFilter(list: lists[indexPath.row])
            } else {
                listDelegate?.addFilter(list: lists[indexPath.row])
            }
            
            cell.isSelect = !cell.isSelect
            
            selectedCell[indexPath.row] = cell.isSelect
        }
    }
}
