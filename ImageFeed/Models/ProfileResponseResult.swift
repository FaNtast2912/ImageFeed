//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 08.10.2024.
//

import Foundation

struct ProfileResponseResult: Decodable {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    let username: String
    let name: String?
    let firstName: String?
    let lastName: String?
//    let bio: String?
    // MARK: - Private Properties
    private enum CodingKeys: String, CodingKey {
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
//        case bio
    }

    // MARK: - Initializers
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        name = try container.decode(String.self, forKey: .name)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
//        bio = try container.decode(String.self, forKey: .bio)
       
    }
    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods

    // MARK: - Private Methods
}
