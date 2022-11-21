//
//  FeedVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    
    //MARK: - Helpers
    private func configureUI(){
        collectionView.backgroundColor    = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutPressed))
        navigationItem.title              = "Feed"
    }
    
    
    private func configureCollectionView(){
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    //MARK: - @objc Action Helpers
    @objc private func logoutPressed() {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginVC()
            let navigate = UINavigationController(rootViewController: loginVC)
            navigate.modalPresentationStyle = .fullScreen
            self.present(navigate, animated: true, completion: nil)
        } catch {
            print("Failed to sign out")
        }
    }
}


//MARK: - UICollectionViewDataSource
extension FeedVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
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
