//
//  Untitled.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 16.11.2024.
//
import UIKit

public protocol ProfileViewControllerStubProtocol {
    var fullNameTextLabel: UILabel { get set }
    var profileLoginTextLabel: UILabel { get set }
    var profileStatusTextLabel: UILabel { get set }
    
    func updateProfile(profile: Profile)
}
