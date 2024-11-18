//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 14.11.2024.
//

import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
}
