//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 20.09.2024.
//

import Foundation

protocol NetworkRouting {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}

final class OAuth2Service: NetworkRouting {
    // MARK: - IB Outlets
    
    // MARK: - Public Properties
    static let shared = OAuth2Service()
    
    // MARK: - Private Properties
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
    
    func fetch(request: URLRequest, handler: @escaping (Result<Data, any Error>) -> Void) {

        let task = URLSession.shared.dataTask(with: request) { data,response,error in
            
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            guard let data = data else {return}
            handler(.success(data))
        }
        task.resume()
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
