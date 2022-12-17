//
//  FeedVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit
import Firebase

final class FeedVC: UICollectionViewController {
    
    //MARK: - Properties
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    var post: Post?
    
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
        collectionView.refreshControl     = customRefresher
        customRefresher.addTarget(self, action: #selector(detectRefresh), for: .valueChanged)
    }
    
    
    //MARK: - API Operations
    private func fetchPosts(isRenewable: Bool) {
        guard post == nil else { return }
        PostService.fetchPosts { posts in
            self.posts = posts
            self.checkUserLikeAtPost()
            if isRenewable { self.collectionView.refreshControl?.endRefreshing() }
        }
    }
    
    
    private func checkUserLikeAtPost() {
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts.firstIndex(where: { $0.postID == post.postID }) {
                    self.posts[index].didLike = didLike
                }
            }
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
    
    
    @objc func detectRefresh() {
        posts.removeAll()
        fetchPosts(isRenewable: true)
    }
}


//MARK: - UICollectionViewDataSource
extension FeedVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseID, for: indexPath) as! FeedCell
        item.delegate = self
        if let post = post {
            item.viewModel = PostViewModel(post: post)
        } else {
            item.viewModel = PostViewModel(post: posts[indexPath.row])
        }
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


//MARK: - FeedCellProtocolDelegate
extension FeedVC: FeedCellProtocolDelegate {
    //CLICK THEN GO TO USER PROFILE FROM FEEDVC
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let ProfileVC = ProfileVC(user: user)
            self.navigationController?.pushViewController(ProfileVC, animated: true)
        }
    }
    
    
    //GO TO COMMENT DETAILS
    func cell(_ cell: FeedCell, showCommentsFor post: Post) {
        let commentVC = CommentVC(post: post)
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    
    //STATUS FOR LIKE OF POST
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        if post.didLike {
            PostService.unlikePost(post: post) { error in
                if let error = error {
                    print("Post unline operation is failed: \(error)")
                    return
                }
                cell.postLikeButton.setImage(FeedImages.likeUnselected, for: .normal)
                cell.postLikeButton.tintColor = .black
                cell.viewModel?.post.likes    = post.likes - 1
            }
        } else {
            PostService.likePost(post: post) { error in
                if let error = error {
                    print("Post like operation is failed: \(error)")
                    return
                }
                cell.postLikeButton.setImage(FeedImages.likeSelected, for: .normal)
                cell.postLikeButton.tintColor = .red
                cell.viewModel?.post.likes    = post.likes + 1
                
                NotificationService.uploadNotification(toUID: post.ownerUid, type: .like, post: post)
            }
        }
    }
    
}
