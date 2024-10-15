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
    private var splashScreenLogoImageView: UIImageView?
    private var alertPresenter: AlertPresenterProtocol?
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
        alertPresenter = AlertPresenter(delegate: self)
        setupSplashScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isAuthenticated()
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
                guard let self else { preconditionFailure("Weak self error") }
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
            }
            
        } else {
            let authViewController = AuthViewController()
            authViewController.delegate = self
            authViewController.modalPresentationStyle = .fullScreen
            present(authViewController, animated: true)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarController")
        window.rootViewController = tabBarController
    }
    
    private func fetchOAuthToken(_ code: String) {
        UIBlockingProgressHUD.show()
        oauth2Service.fetchOAuthToken(code) { [weak self] result in
            guard let self else { preconditionFailure("Weak self error") }
            switch result {
            case .success:
                self.fetchProfile { UIBlockingProgressHUD.dismiss() }
            case .failure(let error):
                print("fetch token error \(error)")
                self.showAlert()
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
                self.switchToTabBarController()
                let username = profile.username
                self.fetchProfileImage(username: username)
            case .failure(let error):
                print("fetch token error \(error)")
            }
            completion()
        }
    }
    
    private func fetchProfileImage(username: String) {
        profileImageService.fetchImageURL(with: username) { result in
            switch result {
            case .success(let imageURL):
                print("imageURL - \(imageURL)")
            case .failure(let error):
                print("fetch image error \(error)")
            }
        }
    }
    
    private func showAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { preconditionFailure("weak self error")}
            let alertModel = AlertModel(
                title: "Что-то пошло не так(",
                message: "Не удалось войти в систему",
                buttonText: "Ок"
            ) { [weak self] in
                guard let self else { preconditionFailure("weak self error")}
                self.authenticateStatus = false
                self.isAuthenticated()
            }
            self.alertPresenter?.showAlert(model: alertModel)
        }
    }
    
    private func setSplashScreenLogoImageView() {
        let splashScreenLogoImageView = UIImageView()
        let splashScreenLogo = UIImage(named: "splashScreenLogo")
        splashScreenLogoImageView.image = splashScreenLogo
        splashScreenLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashScreenLogoImageView)
        splashScreenLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        splashScreenLogoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 272).isActive = true
        splashScreenLogoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -464).isActive = true
        self.splashScreenLogoImageView = splashScreenLogoImageView
    }
    
    private func setupSplashScreen() {
        setSplashScreenLogoImageView()
        view.backgroundColor = .ypBlack
    }
}