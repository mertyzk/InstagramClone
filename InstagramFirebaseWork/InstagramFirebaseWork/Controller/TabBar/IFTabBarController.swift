//
//  IFTabBarController.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 24.10.2022.
//

import UIKit
import Firebase
import YPImagePicker

final class IFTabBarController: UITabBarController {
    
    //MARK: - Properties
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureVCs(withUser: user)
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor    = #colorLiteral(red: 0.8650696874, green: 0.8748025298, blue: 0.874617517, alpha: 1)
        tabBar.tintColor       = .black
        checkCurrentUser()
        fetchUser()
    }
    
    
    // MARK: - API
    private func checkCurrentUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                loginVC.delegate = self
                let navigate = UINavigationController(rootViewController: loginVC)
                navigate.modalPresentationStyle = .fullScreen
                self.present(navigate, animated: true, completion: nil)
            }
        }
    }
    
    
    private func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    
    //MARK: - Helpers
    private func configureVCs(withUser user: User){
        self.delegate                       = self
        let layout                          = UICollectionViewFlowLayout()
        let profile                         = ProfileVC(user: user)
        let feedVC                          = configureNavigationController(rootVC: FeedVC(collectionViewLayout: layout), unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        let searchVC                        = configureNavigationController(rootVC: SearchVC(), unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
        let imageSelectorVC                 = configureNavigationController(rootVC: ImageSelectorVC(), unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        let notificationsVC                 = configureNavigationController(rootVC: NotificationsVC(), unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        let profileVC                       = configureNavigationController(rootVC: profile, unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"))
        
        viewControllers                     = [feedVC, searchVC, imageSelectorVC, notificationsVC, profileVC]
    }
    
    
    private func configureNavigationController(rootVC: UIViewController, unselectedImage: UIImage, selectedImage: UIImage) -> UINavigationController {
        let navigation                      = UINavigationController(rootViewController: rootVC)
        navigation.tabBarItem.image         = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        return navigation
    }
    
    
    private func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: false) {
                guard let selectedImage     = items.singlePhoto?.image else { return }
                let uploadPostVC            = UploadPostVC()
                uploadPostVC.selectedImage  = selectedImage
                uploadPostVC.delegate       = self
                uploadPostVC.currentUser    = self.user
                let navigationController    = UINavigationController(rootViewController: uploadPostVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: false)
            }
        }
    }
}


//MARK: - Authentication Delegate
extension IFTabBarController: AuthenticationProtocol {
    func authenticationComplete() {
        fetchUser()
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - UITabBarControllerDelegate
extension IFTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index                           = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var config                      = YPImagePickerConfiguration()
            config.library.mediaType        = .photo
            config.startOnScreen            = .library
            config.screens                  = [.library]
            config.hidesStatusBar           = false
            config.hidesBottomBar           = false
            config.library.maxNumberOfItems = 1
            config.shouldSaveNewPicturesToAlbum = false
            let picker                      = YPImagePicker(configuration: config)
            picker.modalPresentationStyle   = .fullScreen
            present(picker, animated: true)
            didFinishPickingMedia(picker)
        }
        return true
    }
}


//MARK: - UploadPostVCDelegateProtocol
extension IFTabBarController: UploadPostVCDelegateProtocol {
    func controllerDidFinishUploadingPost(_ controller: UploadPostVC) {
        selectedIndex = 0
        controller.dismiss(animated: true)
        guard let feedNavigation            = viewControllers?.first as? UINavigationController else { return }
        guard let feed                      = feedNavigation.viewControllers.first as? FeedVC else { return }
        feed.detectRefresh()
    }
}
