//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 7/09/21.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentAlertControllerOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertController = AlertController(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertController.modalPresentationStyle = .overFullScreen
            alertController.modalTransitionStyle = .crossDissolve
            self.present(alertController, animated: true)
        }
    }
            
    func presentSafariVC(with url: URL)  {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
