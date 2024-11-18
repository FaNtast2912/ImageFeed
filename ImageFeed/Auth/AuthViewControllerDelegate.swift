//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 12.10.2024.
//

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}
