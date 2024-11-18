//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 13.11.2024.
//
import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}
