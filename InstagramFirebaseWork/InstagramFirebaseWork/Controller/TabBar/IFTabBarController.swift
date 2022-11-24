//
//  IFTabBarController.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit
import Firebase

class IFTabBarController: UITabBarController {
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = #colorLiteral(red: 0.8650696874, green: 0.8748025298, blue: 0.874617517, alpha: 1)
        tabBar.tintColor       = .black
        configureVCs()
        checkCurrentUser()
    }
    
    
    // MARK: - API
    func checkCurrentUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navigate = UINavigationController(rootViewController: loginVC)
                navigate.modalPresentationStyle = .fullScreen
                self.present(navigate, animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: - Helpers
    func configureVCs(){
        let layout             = UICollectionViewFlowLayout()
        let profileLayout      = UICollectionViewFlowLayout()
        let feedVC             = configureNavigationController(rootVC: FeedVC(collectionViewLayout: layout), unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        let searchVC           = configureNavigationController(rootVC: SearchVC(), unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
        let imageSelectorVC    = configureNavigationController(rootVC: ImageSelectorVC(), unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        let notificationsVC    = configureNavigationController(rootVC: NotificationsVC(), unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        let profileVC          = configureNavigationController(rootVC: ProfileVC(collectionViewLayout: profileLayout), unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"))
        
        viewControllers        = [feedVC, searchVC, imageSelectorVC, notificationsVC, profileVC]
    }
    
    
    func configureNavigationController(rootVC: UIViewController, unselectedImage: UIImage, selectedImage: UIImage) -> UINavigationController {
        let navigation                      = UINavigationController(rootViewController: rootVC)
        navigation.tabBarItem.image         = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        return navigation
    }

}
