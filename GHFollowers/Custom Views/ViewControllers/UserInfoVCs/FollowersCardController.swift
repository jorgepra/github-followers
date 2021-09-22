//
//  FollowersCardController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 12/09/21.
//

import Foundation

protocol FollowersCardControllerDelegate: AnyObject {
    func didTapGetFollowers(user: User)
}

class FollowersCardController: InfoCardController {
    weak var delegate: FollowersCardControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    fileprivate func configure()  {
        leftItemView.set(itemInfoType: .followers, withCount: user.followers)
        rightItemView.set(itemInfoType: .following, withCount: user.following)
        bottomButton.set(title: "Get Followers", backgroundColor: .systemGreen)
        
    }
    
    override func handleButton() {
        delegate?.didTapGetFollowers(user: user)
    }
}
