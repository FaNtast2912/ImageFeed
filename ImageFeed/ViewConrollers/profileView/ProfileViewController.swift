//
//  ProfileViewFinalController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 06.09.2024.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - IB Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var profileImageView: UIImageView?
    private var exitButton: UIButton?
    private var fullNameTextLabel: UILabel?
    private var profileLoginTextLabel: UILabel?
    private var profileStatusTextLabel: UILabel?
    private var favoritesTextLabel: UILabel?
    private var noFavoritesPhotoPlaceHolder: UIImageView?
    // MARK: - Initializers
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileScreen()
        
    }
    // MARK: - Actions
    @objc
    private func didTapExitButton() {
    }
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    private func setProfileScreen() {
        view.backgroundColor = .ypBlack
        setProfileImage()
        setExitButton()
        setFullNameTextLabel()
        setProfileLoginTextLabel()
        setProfileStatusTextLabel()
        setFavoritesTextLabel()
        setNoFavoritesPhotoPlaceHolder()
    }
    
    private func setProfileImage() {
        let profileImageView = UIImageView()
        let profileImage = UIImage(named: "userPick")
        profileImageView.image = profileImage
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32).isActive = true
        self.profileImageView = profileImageView
    }
    
    private func setExitButton() {
        
        guard let exitImage = UIImage(named: "logout"),
              let profileImageView = self.profileImageView else {return}
        
        let exitButton = UIButton.systemButton(
            with: exitImage,
            target: self,
            action: #selector(Self.didTapExitButton)
        )
        exitButton.tintColor = UIColor(hex: "#F56B6C")
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
        exitButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        self.exitButton = exitButton
    }
    
    private func setFullNameTextLabel() {
        guard let profileImageView = self.profileImageView else { return }
        let fullNameTextLabel = UILabel()
        view.addSubview(fullNameTextLabel)
        fullNameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameTextLabel.text = "Екатерина Новикова"
        fullNameTextLabel.textColor = .white
        fullNameTextLabel.font = .boldSystemFont(ofSize: 23)
        
        fullNameTextLabel.widthAnchor.constraint(equalToConstant: 235).isActive = true
        fullNameTextLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        fullNameTextLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
        fullNameTextLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        self.fullNameTextLabel = fullNameTextLabel
    }
    
    private func setProfileLoginTextLabel() {
        guard let fullNameTextLabel = self.fullNameTextLabel else { return }
        let profileLoginTextLabel = UILabel()
        view.addSubview(profileLoginTextLabel)
        profileLoginTextLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLoginTextLabel.text = "ekaterina_nov"
        profileLoginTextLabel.textColor = .white
        profileLoginTextLabel.font = .systemFont(ofSize: 13)
        
        profileLoginTextLabel.widthAnchor.constraint(equalToConstant: 99).isActive = true
        profileLoginTextLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        profileLoginTextLabel.leadingAnchor.constraint(equalTo: fullNameTextLabel.leadingAnchor).isActive = true
        profileLoginTextLabel.topAnchor.constraint(equalTo: fullNameTextLabel.bottomAnchor, constant: 8).isActive = true
        self.profileLoginTextLabel = profileLoginTextLabel
    }
    
    private func setProfileStatusTextLabel() {
        guard let profileLoginTextLabel = self.profileLoginTextLabel else { return }
        let profileStatusTextLabel = UILabel()
        view.addSubview(profileStatusTextLabel)
        profileStatusTextLabel.translatesAutoresizingMaskIntoConstraints = false
        profileStatusTextLabel.text = "Hello, world!"
        profileStatusTextLabel.textColor = .white
        profileStatusTextLabel.font = .systemFont(ofSize: 13)
        
        profileStatusTextLabel.widthAnchor.constraint(equalToConstant: 77).isActive = true
        profileStatusTextLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        profileStatusTextLabel.leadingAnchor.constraint(equalTo: profileLoginTextLabel.leadingAnchor).isActive = true
        profileStatusTextLabel.topAnchor.constraint(equalTo: profileLoginTextLabel.bottomAnchor, constant: 8).isActive = true
        self.profileStatusTextLabel = profileStatusTextLabel
    }
    
    private func setFavoritesTextLabel() {
        guard let profileStatusTextLabel = self.profileStatusTextLabel else { return }
        let favoritesTextLabel = UILabel()
        view.addSubview(favoritesTextLabel)
        favoritesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritesTextLabel.text = "Избранное"
        favoritesTextLabel.textColor = .white
        favoritesTextLabel.font = .boldSystemFont(ofSize: 23)
        
        favoritesTextLabel.widthAnchor.constraint(equalToConstant: 129).isActive = true
        favoritesTextLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        favoritesTextLabel.leadingAnchor.constraint(equalTo: profileStatusTextLabel.leadingAnchor).isActive = true
        favoritesTextLabel.topAnchor.constraint(equalTo: profileStatusTextLabel.bottomAnchor, constant: 24).isActive = true
        self.favoritesTextLabel = favoritesTextLabel
    }
    
    private func setNoFavoritesPhotoPlaceHolder() {
        let noFavoritesPhotoPlaceHolder = UIImageView()
        let FavoritesPhotoImage = UIImage(named: "noPhoto")
        noFavoritesPhotoPlaceHolder.image = FavoritesPhotoImage
        noFavoritesPhotoPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noFavoritesPhotoPlaceHolder)
        noFavoritesPhotoPlaceHolder.widthAnchor.constraint(equalToConstant: 115).isActive = true
        noFavoritesPhotoPlaceHolder.heightAnchor.constraint(equalToConstant: 115).isActive = true
        noFavoritesPhotoPlaceHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130).isActive = true
        noFavoritesPhotoPlaceHolder.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 332).isActive = true
        self.noFavoritesPhotoPlaceHolder = noFavoritesPhotoPlaceHolder
    }
}

