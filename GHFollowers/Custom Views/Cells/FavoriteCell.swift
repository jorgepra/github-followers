//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 13/09/21.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let usernameLabel = TitleLabel(textAlignment: .center, fontSize: 25)
    let avatarImageView = AvatarImageView(frame: .zero)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    fileprivate func configure() {
        let padding: CGFloat = 12
        accessoryType = .disclosureIndicator
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
        let stack = UIStackView(arrangedSubviews: [avatarImageView, usernameLabel, UIView()])
        stack.spacing = 20
        
        addSubview(stack)
        stack.fillSuperview(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    func set(favorite: Follower)  {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
