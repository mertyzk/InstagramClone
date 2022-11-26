//
//  SearchVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit

class SearchVC: UITableViewController {
    
    //MARK: - Properties
    private var users = [User]()
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUsers()
    }
    
    
    //MARK: - API
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
}


//MARK: - UITableViewDataSource
extension SearchVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseID, for: indexPath) as! SearchCell
        cell.viewModel = UserCellViewModel(user: users[indexPath.row])
        return cell
    }
}


//MARK: - UITableViewDelegate
extension SearchVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = ProfileVC(user: users[indexPath.row])
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
