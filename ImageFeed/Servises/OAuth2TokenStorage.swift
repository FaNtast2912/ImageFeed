//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 21.09.2024.
//

import Foundation

final class OAuth2TokenStorage {
    // MARK: - Private Properties
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case token
    }
    
    var token: String? {
        get {
            storage.string(forKey: Keys.token.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.token.rawValue)
        }
    }
}
