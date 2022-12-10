//
//  ProfileVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit

final class ProfileVC: UICollectionViewController {
    
    //MARK: - Properties
    private var user: User
    private var posts: [Post] = []
    
    
    //MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
        checkIfUserFollowState()
        fetchUserStats()
        fetchUserPosts()
    }

    
    //MARK: - Helpers
    private func configureUI() {
        collectionView.backgroundColor = .white
    }
    
    
    private func configureCollectionView() {
        navigationItem.title = user.username
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseID)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseID)
    }
    
    
    //MARK: - API Operations
    private func checkIfUserFollowState(){
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    
    private func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { userStats in
            self.user.stats = userStats
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    
    private func fetchUserPosts() {
        PostService.fetchUserProfilePosts(forUser: user.uid) { posts in
            self.posts = posts
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
}


//MARK: - UICollectionViewDataSource
extension ProfileVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseID, for: indexPath) as! ProfileCell
        cell.viewModel   = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.reuseID, for: indexPath) as! ProfileHeader
        header.viewModel = ProfileHeaderViewModel(user: user)
        header.delegate  = self
        return header
    }
}


//MARK: - UICollectionViewDelegate
extension ProfileVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedVC      = FeedVC(collectionViewLayout: UICollectionViewFlowLayout())
        feedVC.post     = posts[indexPath.row]
        navigationController?.pushViewController(feedVC, animated: true)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileVC: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
}
    

//MARK: - ProfileHeaderDelegateProtocol
extension ProfileVC: ProfileHeaderDelegateProtocol {
    func header(_ profileHeader: ProfileHeader, editProfileButtonClicked user: User) {
        if user.isCurrentUser {
            print("show edit profile here")
        } else if user.isFollowed {
            //UNFOLLOW USER
            UserService.unfollow(uid: user.uid) { error in
                self.user.isFollowed = false
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
        } else {
            //FOLLOW USER
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
        }
    }
}
