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
    
    
    //MARK: - Properties
    private var users            = [User]()
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
        fetchUsers()
    }
    
    
    //MARK: - API Operations
    func fetchUsers(){
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: - Helpers
    func configureTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseID)
        tableView.rowHeight = 65
    }
    
    
    func configureSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater                 = self
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
