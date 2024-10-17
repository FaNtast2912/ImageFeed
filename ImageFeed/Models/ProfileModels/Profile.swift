//
//  Profile.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 08.10.2024.
//

import Foundation

struct Profile {
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
}
