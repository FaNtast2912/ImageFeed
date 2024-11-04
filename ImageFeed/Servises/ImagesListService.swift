//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 29.10.2024.
//
import Foundation

final class ImagesListService {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    // MARK: - Private Properties
    private let urlSession = URLSession.shared
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private let storage = OAuth2TokenStorage()
    private var dataTask: URLSessionTask?
    private var likeTask: URLSessionTask?
    private enum ImagesServiceError: Error {
        case invalidRequest
    }
    private let dateFormatter = ISO8601DateFormatter()
    // MARK: - Initializers
    private init() {}
    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods
    func clearPhotos() {
        photos.removeAll()
        lastLoadedPage = nil
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Bool , Error>) -> Void) {
        likeTask?.cancel()
        assert(Thread.isMainThread)
        guard let request = makeIsLikeRequest(id: photoId, isLiked: isLike) else {
            preconditionFailure("bad request")
        }
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<LikeModel, Error>) in
            guard let self else { preconditionFailure("self is unavalible") }
            switch result {
            case .success(let isLikedPoto):
                let currentLike = isLikedPoto.photo.likedByUser
                if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                    let photo = self.photos[index]
                    let newPhoto = Photo(
                        id: photo.id,
                        size: photo.size,
                        createdAt: photo.createdAt,
                        welcomeDescription: photo.welcomeDescription,
                        thumbImageURL: photo.thumbImageURL,
                        largeImageURL: photo.largeImageURL,
                        isLiked: currentLike
                    )
                    self.photos[index] = newPhoto
                }
                completion(.success(currentLike))
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: self)
            case .failure(let error):
                print("Images Service Error - \(error)")
            }
        }
        self.likeTask = task
        task.resume()
    }

    func fetchPhotosNextPage() {
        
        assert(Thread.isMainThread)
        
        guard let request = makePhotosRequest() else {
            preconditionFailure("bad request")
        }
        
        guard dataTask == nil else { return }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResponseResult], Error>) in
            guard let self else { preconditionFailure("self is unavalible") }
            switch result {
            case .success(let response):
                response.forEach { response in
                    self.photos.append(self.makePhotos(from: response))
                }
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: self)
                let nextPage = (lastLoadedPage ?? 0) + 1
                self.dataTask = nil
                self.lastLoadedPage = nextPage
            case .failure(let error):
                print("ProfileService Error - \(error)")
            }
            self.dataTask = nil
        }
        self.dataTask = task
        task.resume()
    }
    // MARK: - Private Methods
    private func makePhotos(from result: PhotoResponseResult) -> Photo {
        return Photo(
            id: result.id,
            size: CGSize(
                width: result.width,
                height: result.height
            ),
            createdAt: dateFormatter.date(from: result.createdAt ?? ""),
            welcomeDescription: result.description,
            thumbImageURL: result.urls.thumb,
            largeImageURL: result.urls.full,
            isLiked: result.likedByUser
        )
    }
    
    private func makePhotosRequest() -> URLRequest? {
        let nextPage = (lastLoadedPage ?? 0) + 1
        lastLoadedPage = nextPage
        guard var component = URLComponents(string: Constants.defaultBaseURLString + "/photos") else {
            assertionFailure("Cant make component")
            return nil
        }
        
        component.queryItems = [
            URLQueryItem(name: "page", value: nextPage.description)
        ]
        		
        guard let url = component.url else {
            assertionFailure("Cant make URL")
            return nil
        }
        
        let token = String(describing: storage.token!)
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func makeIsLikeRequest(id: String, isLiked: Bool ) -> URLRequest? {
        
        guard let url = URL(string: Constants.defaultBaseURLString + "/photos/\(id)/like") else {
            assertionFailure("Failed to create URL")
            return nil
        }
        let token = String(describing: storage.token!)
        var request = URLRequest(url: url)
        request.httpMethod = isLiked ? "POST" : "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
