//
//  NotificationsVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit

final class NotificationsVC: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    //MARK: - Helpers
    private func configureTableView() {
        view.backgroundColor     = .white
        navigationItem.title     = "Notifications"
        tableView.rowHeight      = 80
        tableView.separatorStyle = .none
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reuseID)
    }
}


//MARK: - UITableViewDataSource
extension NotificationsVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reuseID, for: indexPath) as! NotificationCell
        return cell
    }
}
