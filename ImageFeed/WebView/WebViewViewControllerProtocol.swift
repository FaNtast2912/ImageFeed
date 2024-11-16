//
//  WebViewViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 13.11.2024.
//
import Foundation

public protocol WebViewViewControllerProtocol: AnyObject {
    var presenter: WebViewPresenterProtocol? { get set }
    func load(request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ isHidden: Bool)
}
