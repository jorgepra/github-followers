//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 10/09/21.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel    = TitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text      = message
        self.logoImageView.image    = #imageLiteral(resourceName: "empty-state-logo")
    }
    
    fileprivate func configureMessageLabel() {
        let messageBottomPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 10 : 50
        
        addSubview(messageLabel)
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        messageLabel.anchor(top: nil, leading: leadingAnchor, bottom: centerYAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 40, bottom: messageBottomPadding, right: 40), size: .init(width: 0, height: 200))
    }
    
    fileprivate func configureLogoImageView() {
        addSubview(logoImageView)
        let imageBottomPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? -80 : -40
        logoImageView.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: imageBottomPadding, right: -170))
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
    }
}
