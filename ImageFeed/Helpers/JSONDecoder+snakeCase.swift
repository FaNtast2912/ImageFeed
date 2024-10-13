//
//  JSONDecoder+snakeCase.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 10.10.2024.
//

import Foundation

final class SnakeCaseJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
