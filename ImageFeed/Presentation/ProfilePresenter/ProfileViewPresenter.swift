//
//  ProfileViewPresenter.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 16.11.2024.
//
import Foundation
import UIKit

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    // MARK: - Public Properties
    weak var view: ProfileViewControllerProtocol?
    // MARK: - Private Properties
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let profileLogoutService = ProfileLogoutService.shared
    // MARK: - Public Methods
    
    func viewDidLoad() {
        loadProfile()
        loadAvatar(from: profileImageService.avatarURL)
    }
    
    func loadAvatar(from url: URL?) {
        view?.updateAvatar(from: url)
    }
    
    func loadProfile() {
        guard let profile = profileService.profile else {
            print("Profile didn't download")
            return
        }
        view?.updateProfile(profile: profile)
    }
    
    func logoutDidTapped() {
        profileLogoutService.logout()
        switchToSplashViewController()
    }
    // MARK: - Private Methods
    private func switchToSplashViewController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        window.rootViewController = SplashViewController()
        window.makeKeyAndVisible()
    }
}
