//
//  NotificationsVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit

final class NotificationsVC: UITableViewController {
    
    //MARK: - Properties
    private var notifications = [Notification]() {
        didSet { DispatchQueue.main.async { self.tableView.reloadData() } }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNotifications()
    }
    
    
    //MARK: - Helpers
    private func configureTableView() {
        view.backgroundColor     = .white
        navigationItem.title     = "Notifications"
        tableView.rowHeight      = 80
        tableView.separatorStyle = .none
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reuseID)
    }
    
    
    //MARK: - API Operations
    private func fetchNotifications() {
        NotificationService.fetchNotifications { notifications in
            self.notifications = notifications
            self.checkIfUserIsFollowed()
        }
    }
    
    
    private func checkIfUserIsFollowed() {
        notifications.forEach { notification in
            guard notification.type == .follow else { return }
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.id == notification.id }) {
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }
    }
}


//MARK: - UITableViewDataSource
extension NotificationsVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell       = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reuseID, for: indexPath) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate  = self
        return cell
    }
}


//MARK: - UITableViewDelegate
/*extension NotificationsVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
}*/

//MARK: - NotificationCellDelegateProtocol
extension NotificationsVC: NotificationCellDelegateProtocol {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        print("DEBUG: FOLLOW USER HERE")
    }
    
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String) {
        print("DEBUG: UNFOLLOW USER HERE")
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        print("DEBUG: GO TO POST HERE")
    }
}
