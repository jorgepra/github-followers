//
//  SearchTextField.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 1/09/21.
//

import UIKit

class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()  {
        layer.cornerRadius  = 10
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.systemGray3.cgColor
        
        textColor                   = .label // white in light mode, black in darkmode
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        autocapitalizationType  = .none
        backgroundColor         = .tertiarySystemBackground // not too bold
        autocorrectionType      = .no
        returnKeyType           = .go
        clearButtonMode         = .whileEditing
        placeholder             = "Enter a username"
    }
}
