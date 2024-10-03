//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 20.09.2024.
//

import Foundation

final class OAuth2Service {
    // MARK: - Public Properties
    
    var authToken: String? {
        get {
            OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    
    static let shared = OAuth2Service()
    
    // MARK: - Private Properties
    private let decoder = JSONDecoder()
    
    private let urlSession = URLSession.shared
    
    private enum NetworkError: Error {
        case codeError
    }
    
    private enum OAuth2ServiceConstants {
        static let unsplashGetTokenURLString = "https://unsplash.com/oauth/token"
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, any Error>) -> Void) {
        
        let request = makeOAuthTokenRequest(code: code)
        
        let task = urlSession.data(for: request) { [weak self] result in
            
            guard let self else { preconditionFailure("self is unavalible") }
            
            switch result {
            case .success(let data):
                
                do {
                    let OAuthTokenResponseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    self.authToken = OAuthTokenResponseBody.accessToken
                    completion(.success(OAuthTokenResponseBody.accessToken))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest {
        guard var urlComponents = URLComponents(string: OAuth2ServiceConstants.unsplashGetTokenURLString) else {
            preconditionFailure("invalid scheme or host name")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let url = urlComponents.url else {
            preconditionFailure("Cannot make url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    // MARK: - Private Methods
    
}
