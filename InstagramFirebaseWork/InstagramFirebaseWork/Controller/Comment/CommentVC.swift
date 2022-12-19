//
//  CommentVCCollectionViewController.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 10.12.2022.
//

import UIKit

class CommentVC: UICollectionViewController {
    
    //MARK: - Properties
    private let post: Post
    private var comments: [Comment] = []
    
    
    //MARK: - UI Elements
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame                         = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let ciaView                       = CommentInputAccesoryView(frame: frame)
        ciaView.delegate                  = self
        return ciaView
    }()

    
    //MARK: - Custom Initializer
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        fetchComments()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    //MARK: - API Operations
    func fetchComments() {
        CommentService.fetchComments(forPost: post.postID) { comments in
            self.comments = comments
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    
    //MARK: - Helpers
    private func configureCollectionView(){
        collectionView.backgroundColor      = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode  = .interactive
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.reuseID)
    }
    
    
    private func configureUI(){
        navigationItem.title              = "Comments"
    }
}


//MARK: - UICollectionViewDataSource
extension CommentVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.reuseID, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension CommentVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(withUid: uid) { user in
            let profileVC = ProfileVC(user: user)
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}



//MARK: - UICollectionViewDelegateFlowLayout
extension CommentVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height    = viewModel.size(forWidth: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
}


//MARK: - CommentInputAccesoryViewDelegateProtocol
extension CommentVC: CommentInputAccesoryViewDelegateProtocol {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        guard let IFTabBar = tabBarController as? IFTabBarController else { return }
        guard let currentUser = IFTabBar.user else { return }
        showLoader(true)
        CommentService.uploadComment(comment: comment, postID: post.postID, user: currentUser) { error in
            self.showLoader(false)
            inputView.clearTheCommentTextView()
            NotificationService.uploadNotification(toUid: self.post.ownerUid, fromUser: currentUser, type: .comment, post: self.post)
        }
    }
}
