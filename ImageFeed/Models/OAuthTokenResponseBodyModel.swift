//
//  OAuthTokenResponseBodyModel.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 21.09.2024.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    // MARK: - Private Properties
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
    
    private enum ParseError: Error {
        case createdAtFailure
    }

    // MARK: - Initializers
    
    //А этот init не нужен, CodingKeys сделает свою работу. Вот этот кастомный инит определяют, если нужна какая-то дополнительная логика при преобразовании/маппинге полей, но тут такого нет
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        accessToken = try container.decode(String.self, forKey: .accessToken)
        tokenType = try container.decode(String.self, forKey: .tokenType)
        scope = try container.decode(String.self, forKey: .scope)
        createdAt = try container.decode(Int.self, forKey: .createdAt)
    }
    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods

    // MARK: - Private Methods
}
