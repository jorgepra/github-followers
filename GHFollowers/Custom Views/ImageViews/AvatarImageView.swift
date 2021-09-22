//
//  AvatarImageView.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 8/09/21.
//

import UIKit

class AvatarImageView: UIImageView {
       
    var cache = NetworkManager.shared.cache
    let placeholderImage = #imageLiteral(resourceName: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure()  {
        image = placeholderImage
        layer.cornerRadius = 12
        clipsToBounds = true
        backgroundColor = .systemBackground
    }
    
    func downloadImage(from urlString: String)  {
        image = placeholderImage
        NetworkManager.shared.downloadImage(urlString: urlString) { [weak self] image in
            guard let self = self else {return}
            if let image = image {
                DispatchQueue.main.async {self.image = image}
            }
        }
    }
}
