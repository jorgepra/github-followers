//
//  FavoritesController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 1/09/21.
//

import UIKit

class FavoriteController: DataLoadingController {

    var favorites : [Follower]  = []
    let tableView               = UITableView()
            
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        getFavorites()
    }
    
    fileprivate func configureViewController()  {
        view.backgroundColor = .systemBackground
        title = "Favorites"
    }
    
    fileprivate func configureTableView()  {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.separatorStyle    = .none
        tableView.rowHeight         = 100
        tableView.tableFooterView   = UIView()
        tableView.delegate          = self
        tableView.dataSource        = self
    }
    
    fileprivate func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .failure(let err):
                self.presentAlertControllerOnMainThread(alertTitle: "Something went wrong", message: err.rawValue, buttonTitle: "Ok")
                
            case .success(let favorites):
                self.favorites = favorites
                
                if self.favorites.isEmpty {
                    self.showEmptyView(message: "No favorites?\nAdd one on the follower screen", in: self.view)
                    return
                }
                                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            }
        }
    }
}

extension FavoriteController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let followersController = FollowersController(username: favorite.login)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(followersController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle  == .delete else { return  }
        let favorite        = favorites[indexPath.row]
        
        PersistenceManager.updatewith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            
            if let error = error {
                self.presentAlertControllerOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                return
            }
            
            DispatchQueue.main.async {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
}
