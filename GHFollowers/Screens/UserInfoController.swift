//
//  UserInfoController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 10/09/21.
//

import UIKit

protocol UserInfoControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoController: DataLoadingController {
            
    var username    : String
    var headerView  = UIView()
    let middleView  = UIView()
    let bottomView  = UIView()
    let scrollView  = UIScrollView()
    let contentView = UIView()
    let dateLabel   = BodyLabel(textAlignment: .center)
    weak var delegate    : UserInfoControllerDelegate?
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
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
    
    fileprivate func configureScrollView()  {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.fillSuperview()
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
    }
    
    fileprivate func layoutUI()  {
        contentView.addSubview(headerView)
        contentView.addSubview(middleView)
        contentView.addSubview(bottomView)
        contentView.addSubview(dateLabel)
        
        let padding: CGFloat    = 20
        let heightCard: CGFloat = 160
        headerView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor ,padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 210))
                
        middleView.anchor(top: headerView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: heightCard))
        
        bottomView.anchor(top: middleView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor,padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: heightCard))
        
        dateLabel.anchor(top: bottomView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
    }
    
    fileprivate func getUserInfo() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(username: username) { [weak self] result in
            guard let self = self else {return}
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
