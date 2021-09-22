//
//  BaseListController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 6/09/21.
//

import UIKit

class GFListController: UICollectionViewController {
                
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
