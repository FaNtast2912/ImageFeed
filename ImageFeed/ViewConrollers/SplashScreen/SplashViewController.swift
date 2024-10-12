//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 21.09.2024.
//

import Foundation
import UIKit
import ProgressHUD

final class SplashViewController: UIViewController, AuthViewControllerDelegate {
    // MARK: - IB Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let profileImageService = ProfileImageService.shared
    private let profileService = ProfileService.shared
    private let oauth2Service = OAuth2Service.shared
    private let storage = OAuth2TokenStorage()
    private enum SplashViewControllerConstants {
        static let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    }
    private var authenticateStatus = false
    // MARK: - Initializers
    
    // MARK: - Overrides Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isAuthenticated()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SplashViewControllerConstants.showAuthenticationScreenSegueIdentifier {
            
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(SplashViewControllerConstants.showAuthenticationScreenSegueIdentifier)")
                return
            }
            
            viewController.delegate = self
            
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    // MARK: - IB Actions
    
    // MARK: - Public Methods
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    // MARK: - Private Methods
    
    private func isAuthenticated() {
        guard !authenticateStatus else { return }
        
        authenticateStatus = true
        
        if storage.token != nil {
            UIBlockingProgressHUD.show()
            fetchProfile { [weak self] in
                UIBlockingProgressHUD.dismiss()
                self?.switchToTabBarController()
            }
            
        } else {
            performSegue(withIdentifier: SplashViewControllerConstants.showAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarController")
        window.rootViewController = tabBarController
    }
    
    private func fetchOAuthToken(_ code: String) {
        oauth2Service.fetchOAuthToken(code) { [weak self] result in
            guard let self else { preconditionFailure("Weak self error") }
            switch result {
            case .success:
                self.fetchProfile { UIBlockingProgressHUD.dismiss() }
            case .failure(let error):
                print("fetch token error \(error)")
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    private func fetchProfile(completion: @escaping () -> Void ) {
        guard let token = storage.token else { return }
        
        profileService.fetchProfile(with: token) { [weak self] result in
            guard let self else { preconditionFailure("Weak self error") }
            switch result {
            case .success(let profile):
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
                let username = profile.username
                self.fetchProfileImage(username: username)
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                print("fetch token error \(error)")
            }
            completion()
        }
    }
    
    private func fetchProfileImage(username: String) {
        profileImageService.fetchImageURL(with: username) { [weak self] result in
            guard let self else { preconditionFailure("Weak self error") }
            switch result {
            case .success(let image):
                print("image fetched")
            case .failure(let error):
                print("fetch image error \(error)")
            }
        }
    }
    
    
}
