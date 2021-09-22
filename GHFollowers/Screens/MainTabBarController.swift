//
//  MainTabBarController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 1/09/21.
//

import UIKit

class MainTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavBarController(vc: SearchController(), systemItem: .search, tag: 0),
            createNavBarController(vc: FavoriteController(), systemItem: .favorites, tag: 1),
        ]
        configureNavigationBar()
    }
    
    func createNavBarController(vc: UIViewController, systemItem: UITabBarItem.SystemItem, tag: Int) -> UIViewController {
        let navController   = UINavigationController(rootViewController: vc)
        vc.tabBarItem       = .init(tabBarSystemItem: systemItem, tag: tag)
        return navController
    }
    
    func configureNavigationBar()  {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
}
