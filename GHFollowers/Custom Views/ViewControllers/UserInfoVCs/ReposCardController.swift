//
//  ReposCardController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 12/09/21.
//

import Foundation

protocol ReposCardControllerDelegate: AnyObject {
    func didTapGetProfile(user: User)
}

class ReposCardController: InfoCardController {
    
    weak var delegate : ReposCardControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    fileprivate func configure()  {
        leftItemView.set(itemInfoType: .repos, withCount: user.publicRepos)
        rightItemView.set(itemInfoType: .gists, withCount: user.publicGists)
        bottomButton.set(title: "GitHub Profile", backgroundColor: .systemPurple)
    }
    
    override func handleButton() {
        delegate?.didTapGetProfile(user: user)
    }

}
