//
//  SearchVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit

final class SearchVC: UIViewController {
    
    //MARK: - UI Elements
    private lazy var tableView = UITableView()
    private lazy var collectionView: UICollectionView = {
        let layout                     = UICollectionViewFlowLayout()
        let collectionView             = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate        = self
        collectionView.dataSource      = self
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseID)
        return collectionView
    }()
    
    //MARK: - Properties
    private var users            = [User]()
    private var posts = [Post]()
    private var filteredUsers    = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        configureCollectionView()
        fetchUsers()
        fetchPosts()
    }
    
    
    //MARK: - API Operations
    private func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    
    private func fetchPosts() {
        showLoader(true)
        PostService.fetchPosts { posts in
            self.posts = posts
            DispatchQueue.main.async { self.collectionView.reloadData() }
            self.showLoader(false)
        }
    }
    
    
    //MARK: - Helpers
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight       = 65
        tableView.backgroundColor = .white
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.isHidden        = true
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseID)
        tableView.fillSuperview()
    }
    
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    

    private func configureSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search"
        navigationItem.searchController                       = searchController
        definesPresentationContext                            = false
    }
}


//MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMode ? filteredUsers.count : users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseID, for: indexPath) as! SearchCell
        let user = searchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}


//MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = searchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let profileVC = ProfileVC(user: user)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}


//MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        collectionView.isHidden     = true
        tableView.isHidden          = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text              = nil
        collectionView.isHidden     = false
        tableView.isHidden          = true
    }
}


//MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({
            $0.username.contains(searchText) || $0.fullname.contains(searchText)
        })
        self.tableView.reloadData()
    }
}


//MARK: - UICollectionViewDataSource
extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseID, for: indexPath) as! ProfileCell
        cell.viewModel   = PostViewModel(post: posts[indexPath.row])
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedVC      = FeedVC(collectionViewLayout: UICollectionViewFlowLayout())
        feedVC.post     = posts[indexPath.row]
        navigationController?.pushViewController(feedVC, animated: true)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
}
