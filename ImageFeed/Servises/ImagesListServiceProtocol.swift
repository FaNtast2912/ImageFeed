//
//  ImagesListServiceProtocol.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 17.11.2024.
//

public protocol ImagesListServiceProtocol {
    var photos: [Photo] { get set }
    func sentNotification()
    func fetchPhotosNextPage()
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Bool , Error>) -> Void)
}
