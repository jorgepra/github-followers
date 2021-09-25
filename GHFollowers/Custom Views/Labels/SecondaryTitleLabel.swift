//
//  SecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 22/09/21.
//

import UIKit

class SecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = .systemFont(ofSize: fontSize, weight: .medium)
    }
    
    fileprivate func configure()  {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail // truncated with dots
    }
}
