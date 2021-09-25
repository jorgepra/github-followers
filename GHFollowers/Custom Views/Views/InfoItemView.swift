//
//  InfoItemView.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 12/09/21.
//

import UIKit

class InfoItemView: UIView {
    
    enum ItemInfoType {
        case repos, gists, followers, following
    }
    
    let iconImageView   = UIImageView()
    let titleLabel      = TitleLabel(textAlignment: .center, fontSize: 14)
    let countLabel      = TitleLabel(textAlignment: .center, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutUI()  {
        iconImageView.constrainHeight(20)
        iconImageView.constrainWidth(20)
        iconImageView.contentMode   = .scaleAspectFit
        iconImageView.tintColor     = .label
        iconImageView.image         = SFSymbols.location
        titleLabel.text             = "Public Repos"
        titleLabel.textColor        = .label
        countLabel.text             = "25"
        countLabel.textColor        = .label
        
        let hstack      = UIStackView(arrangedSubviews: [iconImageView,titleLabel])
        hstack.spacing  = 16
        
        let overallStackView        = UIStackView(arrangedSubviews: [hstack, countLabel])
        overallStackView.axis       = .vertical
        overallStackView.alignment  = .center
        
        addSubview(overallStackView)
        overallStackView.fillSuperview()
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int)  {
        switch itemInfoType {
        case .repos:
            iconImageView.image = SFSymbols.repos
            titleLabel.text     = "Public Repos"
        case .gists:
            iconImageView.image = SFSymbols.gists
            titleLabel.text     = "Public Gists"
        case .followers:
            iconImageView.image = SFSymbols.followers
            titleLabel.text     = "Followers"
        case .following:
            iconImageView.image = SFSymbols.following
            titleLabel.text     = "Following"
        }
        countLabel.text         = String(count)
    }
}
