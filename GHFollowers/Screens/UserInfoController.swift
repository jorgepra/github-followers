//
//  UserInfoController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 10/09/21.
//

import UIKit

protocol UserInfoControllerDelegate {
    func didRequestFollowers(for username: String)
}

class UserInfoController: DataLoadingController {
            
    var username    : String
    var headerView  = UIView()
    let middleView  = UIView()
    let bottomView  = UIView()
    let dateLabel   = BodyLabel(textAlignment: .center)
    var delegate    : UserInfoControllerDelegate?
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    fileprivate func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc fileprivate func handleDoneButton()  {
        dismiss(animated: true)
    }
    
    fileprivate func layoutUI()  {
        view.addSubview(headerView)
        view.addSubview(middleView)
        view.addSubview(bottomView)
        view.addSubview(dateLabel)
        
        let padding: CGFloat    = 20
        let heightCard: CGFloat = 160
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor ,padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 210))
                
        middleView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: heightCard))
        
        bottomView.anchor(top: middleView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: heightCard))
        
        dateLabel.anchor(top: bottomView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
    }
    
    fileprivate func getUserInfo() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(username: username) { result in
            self.dismissLoadingView()
            switch result{
            case .failure(let error ):
                print(error)
                self.presentAlertControllerOnMainThread(alertTitle: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            case .success(let user):
                print(user.login)
                
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            }
        }
    }
    
    fileprivate func configureUIElements(with user: User)  {
        let reposCardVC         = ReposCardController(user: user)
        reposCardVC.delegate    = self
        let followersCardVC     = FollowersCardController(user: user)
        followersCardVC.delegate = self
        
        
        self.add(childVC: UserInfoHeaderController(user: user), to: self.headerView)
        self.add(childVC: reposCardVC, to: self.middleView)
        self.add(childVC: followersCardVC, to: self.bottomView)
        self.dateLabel.text = "GitHub since " + user.createdAt.convertToMonthYearFormat()
    }
        
    fileprivate func add(childVC: UIViewController, to containerView: UIView)  {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}

extension UserInfoController: FollowersCardControllerDelegate{
    func didTapGetFollowers(user: User) {
        if user.followers == 0 {
            self.presentAlertControllerOnMainThread(alertTitle: "No followers", message: "This user has no followers. What a shame 😔", buttonTitle: "So sad")
            return
        }
        
        delegate?.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
}

extension UserInfoController: ReposCardControllerDelegate{
    func didTapGetProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentAlertControllerOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this url is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}


//extension UserInfoController: InfoCardControllerDelegate{
//    func didTapGetProfile(user: User) {
//        guard let url = URL(string: user.htmlUrl) else {
//            self.presentGFAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this url is invalid", buttonTitle: "Ok")
//            return
//        }
//        presentSafariVC(with: url)
//    }
//
//    func didTapGetFollowers(user: User) {
//        if user.followers == 0 {
//            self.presentGFAlertOnMainThread(alertTitle: "No followers", message: "This user has no followers. What a shame 😔", buttonTitle: "So sad")
//            return
//        }
//
//        delegate?.didRequestFollowers(for: user.login)
//        dismiss(animated: true)
//    }
//}
