//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 8/09/21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID  = "FollowerCell"
    let avatarImageview = AvatarImageView(frame: .zero)
    let usernameLabel   = TitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()  {
        usernameLabel.text      = "username"
        let padding: CGFloat    = 8
        
        addSubview(avatarImageview)
        avatarImageview.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        avatarImageview.heightAnchor.constraint(equalTo: avatarImageview.widthAnchor).isActive = true
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: avatarImageview.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    }
        
    func set(follower: Follower)  {
        usernameLabel.text = follower.login
        avatarImageview.downloadImage(from: follower.avatarUrl)
    }
}
