//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 08.10.2024.
//

import Foundation

struct ProfileResponseResult: Decodable {
    // MARK: - Public Properties
    let username: String
    let name: String?
    let firstName: String?
    let lastName: String?
    let bio: String?
}
