//
//  GFButton.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 1/09/21.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String, backgroundColor: UIColor = .white) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()  {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) // bold
        titleLabel?.textColor = .white
    }
    
    func set(title: String, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
}
