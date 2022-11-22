//
//  ProfileVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit

class ProfileVC: UICollectionViewController {
    
    //MARK: - Variables
    
    
    
    //MARK: - UI Elements
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPurple
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        collectionView.backgroundColor = .white
    }
    
    private func configureCollectionView(){
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}
