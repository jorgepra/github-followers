//
//  BaseCollectionView.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 9/09/21.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    init(in view: UIView, numberOfCols: CGFloat) {
                
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let paddingSpace                = padding * 2 + minimumItemSpacing * 2
        let availableWidth              = view.bounds.width - paddingSpace
        let widthPerItem                = availableWidth / numberOfCols
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: widthPerItem, height: widthPerItem + 40)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = minimumItemSpacing
        super.init(frame: view.bounds, collectionViewLayout: layout)                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    fileprivate func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
    //        let padding: CGFloat            = 12
    //        let minimumItemSpacing: CGFloat = 10
    //        let itemsPerRow: CGFloat        = 3
    //        let paddingSpace                = padding * 2 + minimumItemSpacing * 2
    //        let availableWidth              = view.bounds.width - paddingSpace
    //        let widthPerItem                = availableWidth / itemsPerRow
    //
    //        let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = .init(width: widthPerItem, height: widthPerItem + 40)
    //        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
    //        layout.minimumLineSpacing = minimumItemSpacing
    //        return layout
    //    }
}
