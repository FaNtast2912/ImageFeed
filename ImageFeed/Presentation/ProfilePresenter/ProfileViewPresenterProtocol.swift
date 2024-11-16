//
//  ProfileViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 16.11.2024.
//
import UIKit

public protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func loadProfile()
    func loadAvatar(from url: URL?)
    func logoutDidTapped()
}
