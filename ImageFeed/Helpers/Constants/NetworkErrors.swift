//
//  NetworkErrors.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 13.10.2024.
//

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case decodeError
}
