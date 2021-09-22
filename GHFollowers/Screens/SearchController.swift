//
//  SearchController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 1/09/21.
//

import UIKit

class SearchController: UIViewController {
    
    let usernameTextField   = SearchTextField()
    let getFollowersButton  = GFButton(title: "Get Followers", backgroundColor: .systemGreen)
    let logoImageView       = Images.ghLogo
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        configureLogoImageView()
        configureTextField()
        configureGetFollowersButton()
        createDismissKeyboardTapGesture()
    }
    
    func createDismissKeyboardTapGesture()  {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func configureTextField() {
        usernameTextField.delegate = self
        view.addSubview(usernameTextField)
        usernameTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
    }
    
    fileprivate func configureLogoImageView() {
        logoImageView.constrainHeight(200)
        logoImageView.constrainWidth(200)
        logoImageView.contentMode = .scaleAspectFill
        
        let topPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 40 : 80
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: topPadding, left: 0, bottom: 0, right: 0))
        logoImageView.centerXInSuperview()
    }
    
    fileprivate func configureGetFollowersButton() {
        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(handleGetFollowers), for: .touchUpInside)
        getFollowersButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 50, right: 50), size: .init(width: 0, height: 50))
    }
        
    @objc fileprivate func handleGetFollowers()  {
        guard let username = usernameTextField.text, !username.isEmpty else {
            self.presentAlertControllerOnMainThread(alertTitle: "Empty Username", message: "Please, enter a username. We need to know who to look for 😄", buttonTitle: "OK")
            return
        }
        usernameTextField.resignFirstResponder()
        
        let followersController = FollowersController(username: username)
        navigationController?.pushViewController(followersController, animated: true)
    }
}

extension SearchController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleGetFollowers()
        return true
    }
}
