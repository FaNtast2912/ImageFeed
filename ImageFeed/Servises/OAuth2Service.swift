//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 20.09.2024.
//

import Foundation

protocol NetworkRouting {
    func fetchOAuthToken(for request: URLRequest, completion: @escaping (Result<OAuthTokenResponseBody, any Error>) -> Void) -> URLSessionTask
}

final class OAuth2Service: NetworkRouting {
    // MARK: - IB Outlets
    
    // MARK: - Public Properties
    static let shared = OAuth2Service()
    
    // MARK: - Private Properties
    private let urlSession = URLSession.shared
    private enum NetworkError: Error {
        case codeError
    }
    private enum OAuth2ServiceConstants {
        static let unsplashGetTokenURLString = "https://unsplash.com/oauth/token"
    }
    // MARK: - Initializers
    private init() {}
    // MARK: - Overrides Methods
    
    // MARK: - IB Actions
    
    // MARK: - Public Methods
    func fetchOAuthToken(for request: URLRequest, completion: @escaping (Result<OAuthTokenResponseBody, any Error>) -> Void) -> URLSessionTask {
        
        let decoder = JSONDecoder()
        
        return urlSession.data(for: request) { result in
            switch result {
            case .success(let data):
                
                do {
                    let OAuthTokenResponseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    completion(.success(OAuthTokenResponseBody))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest {
        guard var urlComponents = URLComponents(string: OAuth2ServiceConstants.unsplashGetTokenURLString) else {
            preconditionFailure("invalide sheme or host name")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_url", value: Constants.redirectURI),
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
