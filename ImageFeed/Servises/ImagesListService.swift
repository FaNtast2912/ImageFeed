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
    // MARK: - Private Properties
    private let urlSession = URLSession.shared
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private let storage = OAuth2TokenStorage()
    private var dataTask: URLSessionTask?
    private enum ImagesServiceError: Error {
        case invalidRequest
    }
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    // MARK: - Initializers
    private init() {}
    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods

    func fetchPhotosNextPage(completion: @escaping (Result<[Photo], any Error>) -> Void) {
        
        assert(Thread.isMainThread)
        
        guard let request = makePhotosRequest() else {
            completion(.failure(ImagesServiceError.invalidRequest))
            return
        }
        
        guard dataTask == nil else { return }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResponseResult], Error>) in
            guard let self else { preconditionFailure("self is unavalible") }
            switch result {
            case .success(let response):
                var photos: [Photo] = []
                response.forEach { response in
                    photos.append(self.makePhotos(from: response))
                }
                completion(.success(photos))
            case .failure(let error):
                print("ProfileService Error - \(error)")
                completion(.failure(error))
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
            largeImageURL: result.urls.thumb,
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
}
