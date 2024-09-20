//
//  Constants.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 19.09.2024.
//

import Foundation

enum Constants {
    static let accessKey = "3zNSGrShYXG9TjxOwE_JyHQNcXer3VsJO8vBRZ8kYw0"
    static let secretKey = "72HwmKAutUivxvd9nOZ2upxWKY0y-vPH79pVIbm_Ans"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL: URL = defaultBaseURLgetter
    static private var defaultBaseURLgetter: URL {
        guard let url = URL(string: "https://api.unsplash.com") else {preconditionFailure("Unable to construct unsplashUrl")}
        return url
    }
    
}
