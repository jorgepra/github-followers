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
    
    let symbolImageView = UIImageView()
    let titleLabel = TitleLabel(textAlignment: .center, fontSize: 14)
    let countLabel = TitleLabel(textAlignment: .center, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    fileprivate func layoutUI()  {
        symbolImageView.constrainHeight(20)
        symbolImageView.constrainWidth(20)
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor   = .label
        symbolImageView.image       = SFSymbols.location
        titleLabel.text             = "Public Repos"
        titleLabel.textColor        = .label
        countLabel.text             = "25"
        countLabel.textColor        = .label
        
        let hstack      = UIStackView(arrangedSubviews: [symbolImageView,titleLabel])
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
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
