//
//  Profile.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 08.10.2024.
//

import Foundation

struct Profile {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    var username: String
    var name: String
    var firstName: String
    var lastName: String
    var loginName: String {
        get {
            return "@\(username)"
        }
    }
    var bio: String?
    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods

    // MARK: - Private Methods
}
