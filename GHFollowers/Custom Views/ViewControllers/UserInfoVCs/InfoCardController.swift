//
//  InfoCardController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 11/09/21.
//

import UIKit

class InfoCardController: UIViewController {
    
    let leftItemView = InfoItemView()
    let rightItemView = InfoItemView()
    let bottomButton = GFButton()
    
    var user: User!    
    //var delegate: InfoCardControllerDelegate?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        configureView()
        layoutUI()
    }
    
    fileprivate func configureView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutUI()  {
        
        let padding: CGFloat = 20
        let hstack = UIStackView(arrangedSubviews: [leftItemView, rightItemView])
        hstack.distribution = .fillEqually
        
        view.addSubview(hstack)
        hstack.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 70))
        
        view.addSubview(bottomButton)
        bottomButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        bottomButton.anchor(top: hstack.bottomAnchor, leading: leftItemView.symbolImageView.leadingAnchor, bottom: nil, trailing: rightItemView.titleLabel.trailingAnchor, size: .init(width: 0, height: 50))
    }
    
    @objc func handleButton() {}
}
