//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 16.11.2024.
//
import Foundation

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol? { get set }
    func updateProfile(profile: Profile?)
    func updateAvatar(from url: URL?)
}
