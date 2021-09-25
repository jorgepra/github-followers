//
//  AlertController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 7/09/21.
//

import UIKit

class AlertController: UIViewController {

    let containerView   = AlertContainerView()
    let titleLabel      = TitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = BodyLabel(textAlignment: .center)
    let actionButton    = GFButton(title: "Ok", backgroundColor: .systemPink)
    var alertTitle      : String?
    var message         : String?
    var buttonTitle     : String?
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = alertTitle
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
        
    fileprivate func configureContainerView()  {
        view.addSubview(containerView)
        containerView.constrainWidth(280)
        containerView.constrainHeight(220)
        containerView.centerInSuperview()
    }
    
    let padding: CGFloat = 20
    
    fileprivate func configureTitleLabel()  {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 28))
    }
    
    fileprivate func configureActionButton()  {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        actionButton.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: 44))
    }
    
    @objc fileprivate func handleActionButton()  {
        dismiss(animated: true, completion: nil)
    }
        
    fileprivate func configureMessageLabel()  {
        containerView.addSubview(messageLabel)
        messageLabel.text           = message
        messageLabel.numberOfLines  = 4
        messageLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: actionButton.topAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: padding, bottom: 12, right: padding))
    }
}
