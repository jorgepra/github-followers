//
//  DataLoadingController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 13/09/21.
//

import UIKit

class DataLoadingController: UIViewController {
    
    fileprivate var containerView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView()  {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {self.containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView()  {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyView(message: String, in view: UIView)  {
        let emptyView = EmptyStateView(message: message)
        view.addSubview(emptyView)
        emptyView.fillSuperview()
    }
}
