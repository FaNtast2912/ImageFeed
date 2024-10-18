//
//  OAuthTokenResponseBodyModel.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 21.09.2024.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    // MARK: - Public Properties
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
