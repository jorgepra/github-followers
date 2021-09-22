//
//  UserInfoHeaderController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 11/09/21.
//

import UIKit

class UserInfoHeaderController: UIViewController {
    
    let avatarImageView     = AvatarImageView(frame: .zero)
    let usernameLabel       = TitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = SecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = SecondaryTitleLabel(fontSize: 18)
    let bioLabel            = BodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUIElements(user: user)
    }
    
    fileprivate func layoutUI()  {        
        let textImagePadding:CGFloat = 12
                
        // avatarImage
        view.addSubview(avatarImageView)
        avatarImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, size: .init(width: 90, height: 90))
        
        // usernameLabel
        view.addSubview(usernameLabel)
        usernameLabel.anchor(top: avatarImageView.topAnchor, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 0, height: 38))
        
        // nameLabel
        view.addSubview(nameLabel)
        nameLabel.anchor(top: nil, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).isActive = true
        
        // location imageView
        view.addSubview(locationImageView)
        locationImageView.anchor(top: nil, leading: avatarImageView.trailingAnchor, bottom: avatarImageView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        
        // location label
        view.addSubview(locationLabel)
        locationLabel.anchor(top: nil, leading: locationImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        
        // bio label
        view.addSubview(bioLabel)
        bioLabel.anchor(top: avatarImageView.bottomAnchor, leading: avatarImageView.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: textImagePadding, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
    }
    
    func configureUIElements(user: User)  {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text          = user.login
        nameLabel.text              = user.name
        locationImageView.image     = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
        locationLabel.text          = user.location ?? "No Location"
        bioLabel.text               = user.bio ?? "No bio available"
        bioLabel.numberOfLines      = 0

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
