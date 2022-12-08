//
//  FeedVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit
import Firebase

final class FeedVC: UICollectionViewController {
    
    //MARK: - Variables
    private var posts = [Post]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        fetchPosts(isRenewable: false)
    }
    
    
    //MARK: - Helpers
    private func configureUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutPressed))
        navigationItem.title              = "Feed"
        configureCollectionViewRefresher()
    }
    
    
    private func configureCollectionView(){
        collectionView.backgroundColor    = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.reuseID)
    }
    
    
    private func configureCollectionViewRefresher() {
        let customRefresher               = UIRefreshControl()
        customRefresher.addTarget(self, action: #selector(detectRefresh), for: .valueChanged)
        collectionView.refreshControl     = customRefresher
    }
    
    
    //MARK: - API
    private func fetchPosts(isRenewable: Bool) {
        PostService.fetchPosts { posts in
            self.posts = posts
            if isRenewable { self.collectionView.refreshControl?.endRefreshing() }
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }

    
    //MARK: - @objc Actions
    @objc private func logoutPressed() {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginVC()
            loginVC.delegate = self.tabBarController as? IFTabBarController
            let navigate = UINavigationController(rootViewController: loginVC)
            navigate.modalPresentationStyle = .fullScreen
            self.present(navigate, animated: true, completion: nil)
        } catch {
            print("Failed to sign out")
        }
    }
    
    
    @objc private func detectRefresh() {
        posts.removeAll()
        fetchPosts(isRenewable: true)
    }
}


//MARK: - UICollectionViewDataSource
extension FeedVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseID, for: indexPath) as! FeedCell
        item.viewModel = PostViewModel(post: posts[indexPath.row])
        return item
    }
}


//MARK: - UICollectionViewFlowLayout
extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width   = view.frame.width
        var height  = width + 8 + 40 + 8
        height     += 110
        
        return CGSize(width: width, height: height)
    }
}
