//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 08.10.2024.
//

import Foundation


final class ProfileService {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    private (set) var profile: Profile?
    static let shared = ProfileService()
    // MARK: - Private Properties
    private var task: URLSessionTask? // для того чтобы смотреть выполняется ли сейчас поход в сеть за токеном
    private var lastToken: String?// для того чтобы запомнить последний токен и потом сравнивать полученный с ним
    private let storage = OAuth2TokenStorage()
    private let decoder = JSONDecoder()
    private let urlSession = URLSession.shared
    
    
    private enum AuthServiceError: Error {
        case invalidRequest
    }
    
    private enum NetworkError: Error {
        case codeError
    }
    
    private enum profileResultsConstants {
        static let unsplashGetProfileResultsURLString = "https://api.unsplash.com/me"
    }
    // MARK: - Initializers
    private init() {}
    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods
    func fetchOAuthToken(_ token: String, completion: @escaping (Result<Profile, any Error>) -> Void) {
        
        assert(Thread.isMainThread) // вроде как проверка на то что мы в главном потоке.
        
        if task != nil {
            if lastToken != token {
                task?.cancel()
            } else {
                completion(.failure(AuthServiceError.invalidRequest))
                return
            }
        } else {
            if lastToken == token {
                completion(.failure(AuthServiceError.invalidRequest))
                return
            }
        }
        
        lastToken = token
        
        guard let request = makeProfileResultRequest() else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        let task = urlSession.data(for: request) { [weak self] result in
            
            guard let self else { preconditionFailure("self is unavalible") }
            
            
            switch result {
            case .success(let data):
                
                do {
                    let ProfileResponseResult = try self.decoder.decode(ProfileResponseResult.self, from: data)
                    let username = ProfileResponseResult.username
                    let name = ProfileResponseResult.name
                    let firstName = ProfileResponseResult.firstName
                    let lastName = ProfileResponseResult.lastName
//                    let bio = ProfileResponseResult.bio
                    let profile = Profile(username: username, name: name ?? "", firstName: firstName ?? "", lastName: lastName ?? "", bio: "")
                    completion(.success(profile))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            self.task = nil
            self.lastToken = nil
            
        }
        self.task = task
        task.resume()
    }
    
    func makeProfileResultRequest() -> URLRequest? {
        guard let url = URL(string: profileResultsConstants.unsplashGetProfileResultsURLString) else {
            assertionFailure("Cant make URL")
            return nil
        }
        
        let token = String(describing: storage.token!)
        print(token)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    // MARK: - Private Methods
    
}
