//
//  BaseCLCell.swift
//  Base
//
//  Created by Be More on 2/11/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit

class BaseCLCell: UICollectionViewCell {
    private static func nibName() -> String {
        return String(describing: self.self)
    }
    
    static func size() -> CGSize {
        return CGSize.zero
    }
    
    static func registerCellByNib(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: self.nibName(), bundle: nil), forCellWithReuseIdentifier: self.nibName())
    }
    
    static func registerCellByClass(collectionView: UICollectionView) {
        collectionView.register(self.self, forCellWithReuseIdentifier: self.nibName())
    }
    
    static func loadCell(collectionView: UICollectionView, indexPath: IndexPath) -> BaseCLCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.nibName(), for: indexPath) as? BaseCLCell else {
            return BaseCLCell()
        }
        return cell
    }
}
