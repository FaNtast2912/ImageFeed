//
//  Photo.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 29.10.2024.
//
import UIKit

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: URL
    let largeImageURL: URL
    let isLiked: Bool
}
