//
//  FollowersController.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 6/09/21.
//

import UIKit


class FollowersController: DataLoadingController{
    
    enum Section { case main }
    
    fileprivate var username            : String!
    fileprivate var followers           : [Follower] = []
    fileprivate var filteredFollowers   : [Follower] = []
    var collectionView                  : UICollectionView!
    var dataSource                      : UICollectionViewDiffableDataSource<Section,Follower>!
    var hasMoreFollowers                = true
    var isSearching                     = false
    var isLoadingMoreFollowers          = false
    var page                            = 1
    
    init(username: String ) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
                
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(numberPage: page)
        configureDataSource()
    }
    fileprivate func configureViewController()  {
        let addBarButtonItem                = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        navigationItem.rightBarButtonItem   = addBarButtonItem
        navigationItem.title                = username
        navigationController?.navigationBar.prefersLargeTitles = true
    }
            
    @objc fileprivate func handleAddButton()  {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(username: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result{
            case .failure(let error):
                self.presentAlertControllerOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            case .success(let user):
                self.addUserToFavorites(user)
            }
        }
    }
      
    fileprivate func addUserToFavorites(_ user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updatewith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            
            if let error = error {
                self.presentAlertControllerOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                return
            }
            
            self.presentAlertControllerOnMainThread(alertTitle: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
        }
    }
    
    fileprivate func configureSearchController()  {
        let searchController = UISearchController()
        searchController.searchResultsUpdater   = self
        searchController.searchBar.placeholder  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController         = searchController
    }
    
    fileprivate func configureCollectionView()  {
        collectionView                  = BaseCollectionView(in: view, numberOfCols: 3)
        collectionView.delegate         = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        view.addSubview(collectionView)
    }
        
    fileprivate func configureDataSource()  {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
            
    fileprivate func getFollowers(numberPage: Int)  {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(username: username, page: numberPage) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result{
            case .failure( let error):
                self.presentAlertControllerOnMainThread(alertTitle: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            case .success(let followers):
                self.updateUI(with: followers)
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    fileprivate func updateUI(with followers: [Follower]) {
        if followers.count < NetworkManager.shared.itemsPerPage { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😁."
            DispatchQueue.main.async { self.showEmptyView(message: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    fileprivate func updateData(on followers: [Follower])  {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
}

// MARK:- UICollectionViewDelegate

extension FollowersController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            self.getFollowers(numberPage: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray             = isSearching ? filteredFollowers : followers
        let follower                = activeArray[indexPath.item]
        let userInfoController      = UserInfoController(username: follower.login)
        userInfoController.delegate = self
        let navController           = UINavigationController(rootViewController: userInfoController)
        present(navController, animated: true)
    }
}

extension FollowersController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter    = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching         = true
        filteredFollowers   = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
}

extension FollowersController: UserInfoControllerDelegate{
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(numberPage: page)
    }
}
