//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 20.09.2024.
//

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
