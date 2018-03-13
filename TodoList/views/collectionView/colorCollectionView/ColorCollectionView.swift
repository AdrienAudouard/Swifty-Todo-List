//
//  ColorCollectionView.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class ColorCollectionView: UICollectionView {

    let colors: [UIColor] = [UIColor(hex: "#1abc9c"), UIColor(hex: "#2ecc71"), UIColor(hex: "#3498db"),
                             UIColor(hex: "#9b59b6"), UIColor(hex: "#34495e"), UIColor(hex: "#f1c40f"),
                             UIColor(hex: "#e67e22"), UIColor(hex: "#e74c3c")]
    
    var selectedColorIndex: Int = -1
    var selectedColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
        self.delegate = self
        
        selectedColor = colors[0]
    }
}

extension ColorCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        
        cell.color = colors[indexPath.row]
        cell.isSelect = indexPath.row == selectedColorIndex
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ColorCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for indexP in collectionView.indexPathsForVisibleItems {
            let cell = collectionView.cellForItem(at: indexP) as! ColorCollectionViewCell
            
            cell.isSelect = indexPath == indexP
            
            if indexPath == indexPath {
                selectedColor = cell.color
                selectedColorIndex = indexPath.row
            }
        }
    }
}
