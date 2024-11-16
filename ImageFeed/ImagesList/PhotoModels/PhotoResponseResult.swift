//
//  PhotoResponseResult.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 30.10.2024.
//

struct PhotoResponseResult: Decodable {
    let id: String
    let width, height: Int
    let createdAt: String?
    let description: String?
    let likedByUser: Bool
    let urls: Urls
}

